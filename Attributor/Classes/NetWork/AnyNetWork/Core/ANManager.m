//
//  ANManager.m
//  Attributor
//
//  Created by jady on 2017/2/10.
//  Copyright © 2017年 张栋栋. All rights reserved.
//


#import "ANManager.h"
#import "ANRequest.h"
#import "ANError.h"
#import "Reachability.h"
//#import "ANMtopPlugin.h"

@interface ANManager ()

/**
 *  网络状态，为了内部修改，设置为readwrite。
 */
@property (nonatomic, readwrite) ANNetworkStatus networkStatus;

/**
 *  有效请求的集合。将网络请求放入此集合中，保证对其的所有权。
 */
@property (nonatomic, strong) NSMutableSet *validRequests;

/**
 *  插件字典。存储注册过的插件。
 */
@property (nonatomic, strong) NSMutableDictionary *pluginDictionary;

@end

/**
 *  网络请求队列，调度网络请求，在整个应用生命周期为单队列。
 */
static NSOperationQueue *_sharedNetworkQueue;

/**
 *  操作队列，串行，负责将请求添加到网络请求队列_sharedNetworkQueue。
 */
static dispatch_queue_t _operationQueue;

// 网络队列中，最大并行数
static const NSInteger NETWORK_QUEUE_MAX_CONCURRENT_OPERATION_COUNT_NO_NETWORK = 3; //!< 没有网络时，最大并行数
static const NSInteger NETWORK_QUEUE_MAX_CONCURRENT_OPERATION_COUNT_CELLULAR = 3; //!< 蜂窝网络下，最大并行数
static const NSInteger NETWORK_QUEUE_MAX_CONCURRENT_OPERATION_COUNT_WIFI = 5; //!< WiFi网络下，最大并行数
static const NSInteger NETWORK_QUEUE_MAX_CONCURRENT_OPERATION_COUNT_DEFAULT = NETWORK_QUEUE_MAX_CONCURRENT_OPERATION_COUNT_WIFI; //!< 默认最大并行数

static const char* OPERATION_QUEUE_NAME = "com.alibaba.anynetwork.anmanager.operationqueue"; //!< 操作队列的名称

@implementation ANManager

#pragma mark - 生命周期

+ (void)initialize {
    // 如果有子类，会多次调用此方法，
    // 为避免多次调用，做此判断，如果不是自己调用，直接返回
    if (self != [ANManager self]) {
        return;
    }
    
    // 保证队列只创建一次，实现类似单例的效果
    if (!_sharedNetworkQueue) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedNetworkQueue = [[NSOperationQueue alloc] init];
            _sharedNetworkQueue.maxConcurrentOperationCount = NETWORK_QUEUE_MAX_CONCURRENT_OPERATION_COUNT_DEFAULT;
            
            _operationQueue = dispatch_queue_create(OPERATION_QUEUE_NAME, DISPATCH_QUEUE_SERIAL);
        });
    }
}

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    
    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedInstance = [[self alloc] init];
//        ANMtopPlugin *plugin = [[ANMtopPlugin alloc] init];
//        [_sharedInstance  registerPlugin:plugin forType:@"mtopRequest"];
//    });
    
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.validRequests = [[NSMutableSet alloc] init];
        self.pluginDictionary = [[NSMutableDictionary alloc] init];
        [self addObservers];
    }
    return self;
}

- (void)dealloc {
    [self removeObservers];
}

#pragma mark - 监听

/**
 *  添加所有监听。
 */
- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChanged:) name:kReachabilityChangedNotification object:nil];
}

/**
 *  删除所有监听。
 */
- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  网络状态变化时，进行处理。
 *
 *  @param notification 网络变化通知
 */
- (void)reachabilityDidChanged:(NSNotification *)notification {
    
    Reachability *reachability = [notification object];
    if (!reachability
        || ![reachability isKindOfClass:[Reachability class]]) {
        return;
    }
    
    if (![reachability respondsToSelector:@selector(currentReachabilityStatus)]) {
        return;
    }
    
    // 根据网络状况设置网络队列最大并发数
    NSInteger maxCount = NETWORK_QUEUE_MAX_CONCURRENT_OPERATION_COUNT_DEFAULT;
    
    switch ([reachability currentReachabilityStatus]) {
        case ReachableViaWiFi: // WiFi
            self.networkStatus = ANNetworkStatusWiFi;
            maxCount = NETWORK_QUEUE_MAX_CONCURRENT_OPERATION_COUNT_WIFI;
            break;
        case ReachableViaWWAN: // 蜂窝
            self.networkStatus = ANNetworkStatusCellular;
            maxCount = NETWORK_QUEUE_MAX_CONCURRENT_OPERATION_COUNT_CELLULAR;
            break;
        case NotReachable: // 没有网络
            self.networkStatus = ANNetworkStatusNoNetwork;
            maxCount = NETWORK_QUEUE_MAX_CONCURRENT_OPERATION_COUNT_NO_NETWORK;
            // 没有网络，取消所有请求
            [self cancelAllRequestsWithUnimportance:NO];
            break;
            
        default:
            maxCount = NETWORK_QUEUE_MAX_CONCURRENT_OPERATION_COUNT_DEFAULT;
            break;
    }
    
    _sharedNetworkQueue.maxConcurrentOperationCount = maxCount;
}

#pragma mark - 网络调度

- (void)enqueueWithRequest:(ANRequest *)request {
    
    ANRequestWillEnqueueBlock willEnqueueBlock = request.willEnqueueBlock;
    if (willEnqueueBlock) {
        willEnqueueBlock();
    }
    
    // 如果无网络，直接处理，不用进入队列
    if (self.networkStatus == ANNetworkStatusNoNetwork) {
        [self handleNoNetworkWithRequest:request];
        return;
    }
    
    // 如果响应类并非ANResponse及其子类，则无法按原有逻辑生成响应，直接返回
    if (!request.responseClass
        || ![request.responseClass isSubclassOfClass:[ANResponse class]]) {
        [self handleUnknownResponseWithRequest:request];
        return;
    }
    
    // 无法处理的请求，返回错误
    if (![self canHandleRequest:request]) {
        [self handleUnknownRequest:request];
        return;
    }
    
    __block ANRequest *blockRequest = request;
    
    // 为避免可能的耗时操作，在 global queue 中异步执行
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 在操作队列中同步执行，添加进网络请求队列
        dispatch_sync(_operationQueue, ^{
            // 此时，request信息已经确定，生成唯一识别码
            [blockRequest generateUniqueIdentifier];
            
            // 判断该请求是否应该添加
            NSString *requestId = blockRequest.uniqueIdentifier;
            
            NSArray *requestsArray = _sharedNetworkQueue.operations;
            for (ANRequest *queuedRequest in requestsArray) {
                // 队列中已经存在相同的请求
                if ([requestId isEqualToString:queuedRequest.uniqueIdentifier]) {
                    // 如果尚未完成，不再重复添加到队列中
                    if (!queuedRequest.isFinished) {
                        return;
                    }
                }
            }
            
            __weak ANManager *weakSelf = self;
            
            // 1. copy原有completedBlock至originalCompletedBlock；
            // 2. 重新设置completedBlock，在其中进行一些预处理；
            // 3. 最终调用originalCompletedBlock。
            ANRequestCompletedBlock originalCompletedBlock = blockRequest.completedBlock;
            
            blockRequest.completedBlock = ^(ANRequest *completedRequest, id completedResponse, ANError *completedError) {
                
                // 如果request为空，无法确定请求，直接返回
                if (!completedRequest) {
                    return;
                }
                
                // isCancelled 标志位不一定准确，故先添加一个判断
                // 如果validRequests中不存在，即没有添加或已被取消，认为是无效请求，直接返回
                if (![weakSelf.validRequests containsObject:completedRequest]) {
                    return;
                }
                
                // 如果请求已经取消，不需处理响应，直接返回
                if (completedRequest.isCancelled) {
                    // 已经取消的请求，应该已经从validRequests删除，不会调到completedBlock
                    // 此处为确保逻辑，执行删除
                    [weakSelf.validRequests removeObject:completedRequest];
                    return;
                }
                
                // 如果需要自动重试，则重试，并返回
                if ([weakSelf shouldRetryRequest:completedRequest error:completedError]) {
                    completedRequest.completedBlock = originalCompletedBlock;
                    [weakSelf retryRequest:completedRequest];
                    return;
                }
                
                // 调用原有完成block
                if (originalCompletedBlock) {
                    originalCompletedBlock(completedRequest, completedResponse, completedError);
                }
                
                // 请求完成时，从有效请求集合中删除，不再保留
                [weakSelf.validRequests removeObject:completedRequest];
            };
            
            // 添加到有效请求集合
            [self.validRequests addObject:blockRequest];
            
            // 添加进网络请求队列
            [_sharedNetworkQueue addOperation:blockRequest];
        });
        
    });
}

- (void)retryRequest:(ANRequest *)request {
    
    request.retryCount++; // 重试次数+1
    request.requestPriority = ANRequestPriorityVeryHigh; // 设置为最高优先级
    
    [self enqueueWithRequest:request];
}

- (void)cancelRequests:(NSArray *)requests {
    
    // 对数组中的请求执行取消操作
    for (ANRequest *request in requests) {
        
        // 如果数组中元素不是ANRequest对象，保护，跳过
        if (![request isKindOfClass:[ANRequest class]]) {
            continue;
        }
        
        [self cancelRequest:request];
    }
}

- (void)cancelAllRequestsWithUnimportance:(BOOL)onlyUnimportantRequests {
    
    // validRequests，包含了：在队列中，还未执行的请求；及已经执行，还未返回的请求
    // 这两种的请求都需要取消
    NSArray *validRequestsArray = [self.validRequests allObjects];
    
    for (ANRequest *request in validRequestsArray) {
        // 如果数组中元素不是ANRequest对象，保护，跳过
        if (![request isKindOfClass:[ANRequest class]]) {
            continue;
        }
        
        // 如果只取消不重要的请求，那么跳过重要请求
        if (onlyUnimportantRequests) {
            if (request.isImportant) {
                continue;
            }
        }
        
        [self cancelRequest:request];
    }
}

#pragma mark - Helper

/**
 *  取消单个请求。
 *
 *  @param request 请求实体。
 */
- (void)cancelRequest:(ANRequest *)request {
    
    if (!request) {
        return;
    }
    
    [request cancel]; // 取消请求
    [self.validRequests removeObject:request]; // 从有效请求集合中删除
}


/**
 *  是否应该重试。
 *
 *  @param request 请求实体。
 *  @param error   网络错误。
 *
 *  @return YES:应该重试；NO：不需重试。
 */
- (BOOL)shouldRetryRequest:(ANRequest *)request error:(ANError *)error {
    
    // 没有错误，不需重试
    if (!error) {
        return NO;
    }
    
    // 没有请求，无法重试
    if (!request) {
        return NO;
    }
    
    if ([self.autoRetryErrorNames containsObject:error.name] // 是需要重试的错误
        && (request.retryCount < request.maxRetryCount)) { // 在重试次数限制内
        return YES;
    }
    
    return NO;
    
    //    BOOL countTag = NO;
    //    BOOL errorTag = NO;
    //
    //    if (!request // 如果request为空，那么主要的判断依据将是error
    //        || (request.retryCount < request.maxRetryCount)) { // 在重试次数限制范围内
    //        countTag = YES;
    //    }
    //
    //    if ((!error || !error.name) // 如果错误名称为空，那么主要判断依据将是request
    //        || [self.autoRetryErrorNames containsObject:error.name]) { // 是需要自动重试的错误
    //        errorTag = YES;
    //    }
    //
    //    BOOL shouldRetry = countTag && errorTag;
    //
    //    return shouldRetry;
}

/**
 *  处理无网络状态。
 *
 *  @param request 请求实体。
 */
- (void)handleNoNetworkWithRequest:(ANRequest *)request {
    
    ANRequestCompletedBlock completedBlock = request.completedBlock;
    if (!completedBlock) {
        return;
    }
    
    ANError *error = [[ANError alloc] init];
    error.name = @"AN_ERROR_NO_NETWORK";
    error.detail = @"无法连接到网络";
    
    completedBlock(request, nil, error);
}

- (void)handleUnknownResponseWithRequest:(ANRequest *)request {
    
    ANRequestCompletedBlock completedBlock = request.completedBlock;
    if (!completedBlock) {
        return;
    }
    
    ANError *error = [[ANError alloc] init];
    error.name = @"AN_ERROR_UNKNOWN_RESPONSE";
    error.detail = [NSString stringWithFormat:@"无法处理的响应类型，%@。请使用ANResponse或其子类", NSStringFromClass(request.responseClass)];
    
    completedBlock(request, nil, error);
}

- (void)handleUnknownRequest:(ANRequest *)request {
    ANRequestCompletedBlock completedBlock = request.completedBlock;
    if (!completedBlock) {
        return;
    }
    
    ANError *error = [[ANError alloc] init];
    error.name = @"AN_ERROR_UNKNOWN_REQUEST";
    error.detail = [NSString stringWithFormat:@"无法处理的请求，type=%@。请检查type，或注册相应的处理plugin", request.requestType];
    
    completedBlock(request, nil, error);
}

#pragma mark - New

- (void)registerPlugin:(id<ANPluginProtocol>)plugin forType:(NSString *)type {
    
    if (!type || !plugin) {
        return;
    }
    
    [self.pluginDictionary setObject:plugin forKey:type];
}

- (BOOL)canHandleRequest:(ANRequest *)request {
    
    if (!request) {
        return NO;
    }
    
    NSString *type = request.requestType;
    if (!type) {
        return NO;
    }
    
    id object = [self.pluginDictionary objectForKey:type];
    if (!object
        || ![object conformsToProtocol:@protocol(ANPluginProtocol)]) {
        [self.pluginDictionary removeObjectForKey:type];
        return NO;
    }
    
    id<ANPluginProtocol> plugin = (id<ANPluginProtocol>)object;
    [plugin parseRequest:request];
    
    return YES;
}

@end
