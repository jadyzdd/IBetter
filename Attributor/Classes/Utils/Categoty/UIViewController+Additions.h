//
//  UIViewController+Additions.h
//  Attributor
//
//  Created by jady on 2016/11/5.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (Additions)

- (void)setLeftNaviBtnImage:(UIImage*)image target:(id)target action:(SEL)action;
- (void)setRightNaviBtnImage:(UIImage*)image target:(id)target action:(SEL)action;

- (void)setLeftNaviBtnImageName:(NSString*)name target:(id)target action:(SEL)action;
- (void)setRightNaviBtnImageName:(NSString*)name target:(id)target action:(SEL)action;

- (void)setLeftNaviBtnTitle:(NSString*)title target:(id)target action:(SEL)action;
- (void)setRightNaviBtnTitle:(NSString*)title target:(id)target action:(SEL)action;

- (void)setNavigationBarTitle:(NSString*)title;
- (void)setNavigationBarTitle:(NSString*)title fontSize:(CGFloat)size textColor:(UIColor*)color;

@end
