//
//  IBMRootViewController.h
//  Attributor
//
//  Created by jady on 2016/11/20.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BViewControllerProtocol.h"
#import "IBRequest.h"

@interface IBMRootViewController : UITabBarController<UINavigationControllerDelegate>

@property (nonatomic,strong) UIView *edgeWind;
@property (nonatomic, assign) MeiziCategory category;

+ (instancetype)sharedInstance;

- (UINavigationController *)currentNavigationController;

- (UIViewController *)currentViewcontroller;

@end
