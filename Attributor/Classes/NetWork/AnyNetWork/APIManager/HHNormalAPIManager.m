//
//  HHNormalAPIManager.m
//  TAFNetworking
//
//  Created by 黑花白花 on 2017/2/17.
//  Copyright © 2017年 黑花白花. All rights reserved.
//

#import "HHNormalAPIManager.h"

@implementation HHNormalAPIManager

- (void)login:(NSString *)username password:(NSString *)password success:(SuccessBlocks)successBlock failure:(FailureBlocks)failureBlock{
    
    HHDataAPIConfiguration *config = [HHDataAPIConfiguration new];
    config.urlPath = @"http://139.196.98.203:3000/api/users";
    config.requestType = HHNetworkRequestTypePost;
    config.requestParameters = @{@"username" : username,
                                 @"password" : password};
    
    
    [self dispatchDataTaskWithConfiguration:config completionHandler:^(NSError *error, id result) {
        if (!error) {

        }
    }];
    
}

- (void)logout{}

- (void)registerUser:(NSString *)username password:(NSString *)password success:(SuccessBlocks)successBlock failture:(FailureBlocks)failureBlock{
}

- (NSNumber *)fetchNearLiveListWithUserId:(NSUInteger)userId isWomen:(BOOL)isWomen completionHandler:(HHNetworkTaskCompletionHander)completionHandler {
    
    HHDataAPIConfiguration *config = [HHDataAPIConfiguration new];
    config.urlPath = @"http://139.196.98.203:3000/api/users";
    config.requestType = HHNetworkRequestTypeGet;
    config.requestParameters = @{@"uid" : @(userId),
                                 @"interest" : @(isWomen)};
    return [self dispatchDataTaskWithConfiguration:config completionHandler:^(NSError *error, id result) {
        
        if (!error) {
            
//            网络请求没问题 但是数据不符合要展示的样式 就在这里格式化错误
//            if (xxx) {
//                error = HHError(@"xxx", HHNormalAPIError0);
//            } else if (yyy) {
//                error = HHError(@"yyy", HHNormalAPIError0);
//            } else if (zzz) {
//                error = HHError(@"zzz", HHNormalAPIError0);
//            }
            
            NSArray *lives = result[@"lives"];
            if (lives.count == 0) {
                error = HHError(HHNoDataErrorNotice, HHNetworkTaskErrorNoData);
            } else {
                
                NSMutableArray *liveList = [NSMutableArray array];
                for (NSDictionary *live in lives) {
                    
                    NSString *liveDescription = [NSString stringWithFormat:@"%@ 正在 %@ 直播, 观看人数: %ld", live[@"name"], live[@"city"], [live[@"online_users"] integerValue]];
                    [liveList addObject:liveDescription];
                }
                result = liveList;
            }
        }
        
        completionHandler ? completionHandler(error, result) : nil;
    }];
}

@end
