//
//  IBMHomeViewController1.h
//  Attributor
//
//  Created by jady on 2016/10/22.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBMHomeViewController1 : UITabBarController<UINavigationControllerDelegate>

@property (nonatomic,strong) UIView *edgeWind;

+ (instancetype)sharedInstance;

- (UINavigationController *)currentNavigationController;

- (UIViewController *)currentViewcontroller;

@end
