//
//  BBaseViewControllers.h
//  Attributor
//
//  Created by jady on 2016/11/5.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BViewControllerProtocol.h"

@interface BBaseViewControllers : UIViewController

@property(nonatomic, assign) UIColor    *backgroundColor UI_APPEARANCE_SELECTOR;

//@property(nonatomic, strong, readonly) YSURLAction    *action;

/**
 * 遵循协议HLViewControllerProtocol.
 */
@property(nonatomic, weak) id hlVCDelegate;

@property(nonatomic, weak) id<BRootViewControllerDelegate> hlRootVCDelegate;

//@property(nonatomic, strong) YJBaseNavigationBar *navigationBar;

//@property(nonatomic, strong) NSString *pageName;
//@property(nonatomic, assign) BOOL showNavBar;



- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query;

/**
 * 设置导航栏半透明属性.
 */
- (void) setNavigationBarTranscluent:(BOOL)transcluent;
- (void) restoreNavigationBarTranscluent;

/**
 * 设置导航栏颜色.请在viewWillAppear中调用.
 */
- (void) setNavigationBarColor:(UIColor *)color;
/**
 * 恢复导航栏颜色.请在viewWillDisappear中调用.
 */
- (void) restoreNavigationBarColor;

/**
 * 显示/隐藏导航栏.
 */
- (void) showNavigationBar:(BOOL)show;

- (void) showNavigationBar:(BOOL)show animated:(BOOL)animated;

/**
 * 恢复导航栏显示/隐藏状态.
 */
- (void) restoreNavigationBar;

/**
 * 导航栏下沿设置阴影.
 */
- (void) setShadowOfNavigationBar:(BOOL)show;

/**
 * 调用页面返回代理方法,即调用hlVCDelegate上的方法(如果存在),页面返回时所带参数由onPoppedParams设置.
 */
- (void) callPopBackDelegate;

#pragma mark - Override this

/**
 *  页面离开之前的事件, 默认基类实现不做任何事.
 */
- (void) onWillPopViewController;

/**
 * 子类如果需要在返回按钮点击事件中传递参数,请override实现并传递需要的参数.
 */
- (NSDictionary *) onPoppedParams;

@end
