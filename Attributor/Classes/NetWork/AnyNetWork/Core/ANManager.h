//
//  ANManager.h
//  Attributor
//
//  Created by jady on 2017/2/10.
//  Copyright © 2017年 张栋栋. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AnyNetwork.h"

@class ANRequest;
@class ANError;
@class ANPlugin;

/**
 *  网络管理器。
 *  负责所有网络请求的调度。
 */
@interface ANManager : NSObject

#pragma mark - 方法

/**
 *  单例。
 *
 *  @return 单例对象
 */
+ (instancetype)sharedInstance;

/**
 *  添加一个请求，入队。
 *
 *  @param request 请求对象
 */
- (void)enqueueWithRequest:(ANRequest *)request;

/**
 *  重试请求。
 *
 *  @param request 请求对象
 */
- (void)retryRequest:(ANRequest *)request;

/**
 *  取消多个请求。
 *
 *  @param requests 需要取消的请求数组，其中存储的是ANRequest实例。
 */
- (void)cancelRequests:(NSArray *)requests;

/**
 *  根据重要性取消请求。
 *
 *  @param onlyUnimportantRequests 是否只取消不重要的请求，YES：只会取消所有important属性为NO的request；NO：取消所有请求。
 */
- (void)cancelAllRequestsWithUnimportance:(BOOL)onlyUnimportantRequests;

/**
 *  根据请求和错误，判断是否应该重试。
 *
 *  @param request 请求
 *  @param error   网络错误
 *
 *  @return YES: 应该重试；NO: 不需重试
 */
//- (BOOL)shouldRetryRequest:(ANRequest *)request error:(ANError *)error;

#pragma mark - 属性

/**
 *  网络状态码。
 */
@property (nonatomic, readonly) ANNetworkStatus networkStatus;

/**
 *  需要自动重试的错误集合。
 *  其中存储的为NSString类型的错误名称，其中的错误会在失败时自动重试。
 */
@property (nonatomic, copy) NSSet *autoRetryErrorNames;

#pragma mark - New

//- (void)registerPlugin:(ANPlugin *)plugin forType:(NSString *)type;
- (void)registerPlugin:(id<ANPluginProtocol>)plugin forType:(NSString *)type;

@end
