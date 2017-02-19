//
//  ANRequest.h
//  Attributor
//
//  Created by jady on 2017/2/10.
//  Copyright © 2017年 张栋栋. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ANConst.h"

@class ANRequest;
@class ANResponse;
@class ANError;

/**
 *  即将入队 block。
 */
typedef void(^ANRequestWillEnqueueBlock)(void);

/**
 *  请求开始 blcok。
 */
typedef void(^ANRequestStartBlock)(void);

/**
 *  请求取消 block。
 */
typedef void(^ANRequestCancelBlock)(void);

/**
 *  进度 block。
 *
 *  @param receivedSize 收到的字节大小
 *  @param expectedSize 期望的字节大小
 */
typedef void(^ANRequestProgressBlock)(long long receivedSize, long long expectedSize);

/**
 *  完成 block。
 *
 *  @param request  请求
 *  @param response 响应
 *  @param error    错误
 */
typedef void(^ANRequestCompletedBlock)(ANRequest *request, ANResponse *response, ANError *error);

/**
 *  网络请求的基类。
 */
@interface ANRequest : NSOperation

#pragma mark - 方法

/**
 *  生成唯一标识。
 *  需要在适当的地方调用该方法，生成标识。
 */
- (void)generateUniqueIdentifier;

/**
 *  设置参数。
 *
 *  @param parameter 参数。
 *  @param key       key。
 */
- (void)setParameter:(id)parameter forKey:(NSString *)key;

/**
 *  获取参数。
 *
 *  @param key key。
 *
 *  @return 参数。
 */
- (id)parameterForKey:(NSString *)key;

#pragma mark - 属性

/**
 *  请求类型。
 *  在执行请求时，会使用注册了该类型的plugin进行请求。
 */
@property (nonatomic, copy) NSString *requestType;

/**
 *  唯一标示符。用于标识请求、过滤相同请求等。
 */
@property (nonatomic, copy, readonly) NSString *uniqueIdentifier;

/**
 *  请求优先级。默认为普通优先级 ANRequestPriorityNormal。
 */
@property (nonatomic, assign) ANRequestPriority requestPriority;

/**
 *  是否是重要的请求。默认为NO。
 *  重要的请求一般是核心的请求，不应该被轻易取消。
 *  @seealso ANManager -cancelAllRequestsWithUnimportance:。
 */
@property (nonatomic, getter=isImportant) BOOL important;

/**
 *  重试次数，记录该请求已经重试了多少次。默认为0。
 */
@property (nonatomic, assign) NSUInteger retryCount;

/**
 *  最大重试次数，标记该请求最多应重试几次，若超过该次数，外部应该做限制。默认为1。
 */
@property (nonatomic, assign) NSUInteger maxRetryCount;

/**
 *  即将入队时，会调用该block。
 *  设置即可，无需手动调用。
 *  如有需要，请设置该block，将即将入队时，希望执行的具体操作，放入其中。
 */
@property (nonatomic, copy) ANRequestWillEnqueueBlock willEnqueueBlock;

/**
 *  请求开始时，会自动调用该block。
 *  设置即可，无需手动调用。
 *  如有需要，请设置该block，将请求开始时，希望执行的具体操作，放入其中。
 */
@property (nonatomic, copy) ANRequestStartBlock startBlock;

/**
 *  请求取消时，会自动调用该block。
 *  设置即可，无需手动调用。
 *  如有需要，请设置该block，将请求取消时，希望执行的具体操作，放入其中。
 */
@property (nonatomic, copy) ANRequestCancelBlock cancelBlock;

/**
 *  请求进度更新时，手动调用的block。
 *  因为进度更新与具体业务相关，故要在合适的地方手动调用。
 *  如有需要，请设置该block，将进度更新时，希望执行的具体操作，放入其中。
 */
@property (nonatomic, copy) ANRequestProgressBlock progressBlock;

/**
 *  请求完成时，手动调用的block。
 *  因为完成时机与具体业务相关，故要在合适的地方手动调用。
 *  如有需要，请设置该block，将请求完成时，执行的具体操作，放入其中。
 */
@property (nonatomic, copy) ANRequestCompletedBlock completedBlock;

/**
 *  附加参数。
 */
//@property (nonatomic, strong) NSMutableDictionary *extraParameters;

/**
 *  响应类的Class。返回响应时可以根据该属性生成所需响应。
 */
@property (nonatomic, strong) Class responseClass;

@end
