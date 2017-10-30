//
//  HHNormalAPIManager.h
//  TAFNetworking
//
//  Created by 黑花白花 on 2017/2/17.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "HHAPIManager.h"


typedef void(^SuccessBlocks)(void);
typedef void(^FailureBlocks)(NSString *error);

@interface HHNormalAPIManager : HHAPIManager
/**
 *  登录接口
 *
 *  @param username     用户名，目前用jid
 *  @param password     密码
 *  @param successBlock 成功回调
 *  @param failureBlock 失败回调
 */
- (void)login:(NSString *)username
     password:(NSString *)password
      success:(SuccessBlocks)successBlock
      failure:(FailureBlocks)failureBlock;

/**
 *  注销登录
 */
- (void)logout;

/**
 *  注册接口
 *
 *  @param username      账号jid
 *  @param password 密码
 */
- (void)registerUser:(NSString *)username
            password:(NSString *)password
             success:(SuccessBlocks)successBlock
            failture:(FailureBlocks)failureBlock;



- (NSNumber *)fetchNearLiveListWithUserId:(NSUInteger)userId isWomen:(BOOL)isWomen completionHandler:(HHNetworkTaskCompletionHander)completionHandler;

@end
