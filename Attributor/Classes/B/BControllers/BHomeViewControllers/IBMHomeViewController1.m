//
//  IBMHomeViewController1.m
//  Attributor
//
//  Created by jady on 2016/10/22.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "IBMHomeViewController1.h"
#import "IBMUserViewController.h"

@interface IBMHomeViewController1 ()<UITabBarDelegate>

@end

@implementation IBMHomeViewController1

+(instancetype)sharedInstance{

    static IBMHomeViewController1 *_instance = nil;
    static dispatch_once_t once = 0 ;
    dispatch_once(&once, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [[UITabBar appearance] setShadowImage:nil];
    [[UITabBar appearance] setBackgroundImage:nil];
    
}

-(void)loadTabBarViewController{

    IBMUserViewController *vc1 = IBMUserViewController.new;
    vc1.hidesBottomBarWhenPushed = YES;
    
    
}


- (UINavigationController *)currentNavigationController{

    return self.viewControllers[self.selectedIndex];
}

- (UIViewController *)currentViewcontroller{

    UINavigationController *navigationController = [self currentNavigationController];
    UIViewController *viewController = [navigationController.viewControllers lastObject];
    return viewController;
    
}

@end
