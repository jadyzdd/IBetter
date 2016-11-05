//
//  IBMViewControllerProtocol.h
//  Attributor
//
//  Created by jady on 2016/11/5.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IBMViewControllerProtocol <NSObject>

/***
 
 返回按钮的点击事件
 **/

- (void) onPopedViewController:(UIViewController *)vc params:(NSDictionary *)params;

@end


@protocol  IBMRootViewControllerProtocol<NSObject>

/***
 tab上页面刷新完成通知Rootview做更新
 **/

- (void) onRefreshComplete;

@end

