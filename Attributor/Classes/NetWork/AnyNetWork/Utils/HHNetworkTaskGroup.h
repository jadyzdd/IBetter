//
//  HHNetworkTaskGroup.h
//  TGCDSocket
//
//  Created by HeiHuaBaiHua on 2016/6/10.
//  Copyright © 2016年 黑花白花. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HHAPIManager.h"
@protocol HHNetworkTask <NSObject>

- (void)cancel;
- (void)resume;

@end

@interface HHNetworkTaskGroup : NSObject

- (void)addTask:(id<HHNetworkTask>)task;

- (void)cancel;
- (void)dispatchWithNotifHandler:(void(^)(void))notifHandler;

@end
