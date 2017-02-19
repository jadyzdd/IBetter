//
//  ANProtocol.h
//  Attributor
//
//  Created by jady on 2017/2/10.
//  Copyright © 2017年 张栋栋. All rights reserved.
//

#ifndef AnyNetwork_ANProtocol_h
#define AnyNetwork_ANProtocol_h

@class ANRequest, ANResponse, ANError;

@protocol ANPluginProtocol <NSObject>

@required
/**
 *  解析请求。应当在该方法中，将传入的请求转化为实际使用的SDK请求。
 *  只实现即可，该方法会在执行请求时自动调用。
 *
 *  @param request 请求。
 */
- (void)parseRequest:(ANRequest *)request;

/**
 *  解析响应。将SDK的响应转化为ANResponse类型。
 *
 *  @param sdkResponse SDK的响应
 *  @param request     请求（可能需要请求的一些参数来生成响应，如responseClass等）。
 *
 *  @return 通用响应 ANResponse。
 */
- (ANResponse *)parseResponse:(id)sdkResponse withRequest:(ANRequest *)request;

/**
 *  解析错误。将SDK的错误转化为ANError类型。
 *
 *  @param sdkError SDK的错误。
 *
 *  @return 通用错误 ANError。
 */
- (ANError *)parseError:(id)sdkError;

@optional
/**
 *  解析设置。应当在该方法中，将传入的设置转化为实际的SDK设置。
 *  因为设置的调用时机跟业务相关，故需在合适的地方手动调用。
 *
 *  @param config 设置。
 */
- (void)parseConfig:(NSDictionary *)config;

@end

#endif
