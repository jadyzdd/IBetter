//
//  AppDelegate.h
//  Attributor
//
//  Created by 张栋栋 on 14-12-30.
//  Copyright (c) 2014年 张栋栋. All rights reserved.
//

#import "IBMHomeViewController.h"

#import "IBMRootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong) IBMHomeViewController *homeController;

@property (nonatomic,strong) IBMRootViewController *rootController;

@end

