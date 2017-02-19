//
//  ANRequest.m
//  Attributor
//
//  Created by jady on 2017/2/10.
//  Copyright © 2017年 张栋栋. All rights reserved.
//


#import "ANRequest.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
#import "ANResponse.h"

@interface ANRequest ()

@property (nonatomic, copy, readwrite) NSString *uniqueIdentifier;

/**
 *  保存外部设置的参数。
 */
@property (atomic, strong) NSMutableDictionary *anInnerParameters;

@end

@implementation ANRequest

#pragma mark - 生命周期

- (instancetype)init {
    if (self = [super init]) {
        
        // 初始化属性
        self.requestPriority = ANRequestPriorityNormal;
        self.retryCount = 0;
        self.maxRetryCount = 1;
        self.important = NO;
        self.responseClass = [ANResponse class];
        
        self.anInnerParameters = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Operation

- (void)main {
    @autoreleasepool {
        // 如果已经取消，直接返回
        if (self.isCancelled) {
            return;
        }
        
        // 开始请求，调用startBlock
        ANRequestStartBlock startBlock = self.startBlock;
        if (startBlock) {
            startBlock();
        }
    }
}

- (void)cancel {
    [super cancel];
    
    // 取消请求，调用cancelBlock
    ANRequestCancelBlock cancelBlock = self.cancelBlock;
    if (cancelBlock) {
        cancelBlock();
    }
}

#pragma mark - 属性

- (void)setRequestPriority:(ANRequestPriority)requestPriority {
    _requestPriority = requestPriority;
    
    // 设置相应的 operation priority
    switch (requestPriority) {
        case ANRequestPriorityVeryLow:
            self.queuePriority = NSOperationQueuePriorityVeryLow;
            break;
        case ANRequestPriorityLow:
            self.queuePriority = NSOperationQueuePriorityLow;
            break;
        case ANRequestPriorityHigh:
            self.queuePriority = NSOperationQueuePriorityHigh;
            break;
        case ANRequestPriorityVeryHigh:
            self.queuePriority = NSOperationQueuePriorityVeryHigh;
            break;
            
        default: // 默认为普通优先级
            self.queuePriority = NSOperationQueuePriorityNormal;
            break;
    }
}

#pragma mark - 参数

- (void)setParameter:(id)parameter forKey:(NSString *)key {
    
    if (!parameter || !key) {
        return;
    }
    
    [self.anInnerParameters setObject:parameter forKey:key];
}

- (id)parameterForKey:(NSString *)key {
    if (!key) {
        return nil;
    }
    
    id parameter = [self.anInnerParameters objectForKey:key];
    return parameter;
}

#pragma mark - Helper

- (void)generateUniqueIdentifier {
    
    // 获取所有属性及其值的字典
    NSDictionary *propertyDictionary = [self allPropertyDictionary];
    
    // 拼接基础字符串，用class name开头，附加属性及值
    NSMutableString *baseString = [NSMutableString stringWithString:NSStringFromClass(self.class)];
    NSString *propertyString = [NSString stringWithFormat:@"%@", propertyDictionary];
    [baseString appendString:propertyString];
    
    // 计算md5
    NSString *md5String = [self md5WithString:baseString];
    
    self.uniqueIdentifier = md5String;
}

/**
 *  获取所有属性&值。
 *
 *  @return 属性&值的字典
 */
- (NSDictionary *)allPropertyDictionary {
    
    NSMutableDictionary *propertyDictionary = [[NSMutableDictionary alloc] init];
    
    u_int count;
    objc_property_t *properties = class_copyPropertyList([ANRequest class], &count);
    NSMutableArray *valuesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        const char* propertyChar = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithUTF8String:propertyChar];
        
        id propertyValue = [self valueForKey:propertyName];
        if (propertyValue) {
            [valuesArray addObject:propertyValue];
            
            [propertyDictionary setObject:propertyValue forKey:propertyName];
        }
    }
    
    free(properties);
    
    return propertyDictionary;
}

/**
 *  计算MD5.
 *
 *  @param string 原始字符串
 *
 *  @return MD5字符串
 */
- (NSString *)md5WithString:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int) strlen(cStr), result);
    
    NSString *md5String = [NSString stringWithFormat:
                           @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    
    return md5String;
}

@end
