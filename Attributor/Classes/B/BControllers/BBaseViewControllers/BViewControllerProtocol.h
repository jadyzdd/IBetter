//
//  BViewControllerProtocol.h
//  Attributor
//
//  Created by jady on 2016/11/5.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BViewControllerProtocol <NSObject>

/****
 返回按钮点击事件
 *****/

- (void) onPopedViewController:(UIViewController *)vc params:(NSDictionary *)params;

@end


@protocol BRootViewControllerProtocol <NSObject>

/*
 *
 **
 用于RootViewController向tab上的页面发送消息
 *****/
- (void) onTabTappedToRefresh:(UIViewController *)vc;

@end

@protocol BRootViewControllerDelegate <NSObject>

/*
 *
 **
 tab上的页面刷新完成通知rootViewCotroller做更新
 *****/
- (void) onRefreshComplete;

@end
