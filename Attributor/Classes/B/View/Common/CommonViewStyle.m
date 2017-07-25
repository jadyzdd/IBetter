//
//  CommonViewStyle.m
//  Attributor
//
//  Created by jady on 2017/3/1.
//  Copyright © 2017年 张栋栋. All rights reserved.
//

#import "CommonViewStyle.h"

@implementation CommonViewStyle

+ (instancetype)shareInstance{

    static id _instance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[[self class] alloc] init];
    });
    
    return _instance;
}


-(void)initViewStyle{

    _scala  = SCREEN_WIDTH/HL_DESIGN_WIDTH;
    
    [UITabBar.appearance setTintColor:UIColor.whiteColor];
    [UITabBar.appearance setBarTintColor:UIColor.whiteColor];
    [UINavigationBar.appearance setTintColor:UIColor.blackColor]; // 返回按钮字体颜色
    [UINavigationBar.appearance setBarStyle:UIBarStyleBlack];
    [UINavigationBar.appearance setBarTintColor:HL_THEME_COLOR]; // 导航栏背景颜色
    [UINavigationBar.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.blackColor, NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
}

+(UIFont *)fontWithBold:(BOOL)isBold size:(CGFloat)size{

    if (isBold) {
        return [UIFont boldSystemFontOfSize:size];
    }
    return [UIFont systemFontOfSize:size];
}

@end
