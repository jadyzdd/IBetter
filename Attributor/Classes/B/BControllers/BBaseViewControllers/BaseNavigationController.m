//
//  BaseNavigationController.m
//  Attributor
//
//  Created by jady on 2016/11/21.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController{

    BOOL _lastAnimationFinished;
    UIViewController *_viewController;
}


- (id)initWithRootViewController:(UIViewController *)rootViewController{

    self = [super initWithRootViewController:rootViewController];
    if (self) {
        if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.interactivePopGestureRecognizer.delegate = self;
        }
        self.delegate = self;
        _lastAnimationFinished = YES;
    }
    return self;
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    _lastAnimationFinished = YES;
    if (_viewController) {
        [super pushViewController:_viewController animated:YES];
        _viewController = nil;
    }
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!_lastAnimationFinished && animated) {
        _viewController = viewController;
        return;
    }
    _lastAnimationFinished = NO;
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    //    if ([[navigationController viewControllers] count] == 1) { //Detail页顶部statusStyle会有变化，回到首屏做处理
    //        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //    }
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 如果只有一个View controller仍然支持屏幕左侧边缘右滑手势会导致后续push操作引起UI假死
    if (self.viewControllers.count > 1) {
        return YES;
    }
    return NO;
}

#pragma mark - Status bar

- (BOOL) prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
