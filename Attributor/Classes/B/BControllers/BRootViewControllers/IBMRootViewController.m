//
//  IBMRootViewController.m
//  Attributor
//
//  Created by jady on 2016/11/20.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "IBMRootViewController.h"
#import "IBMUserViewController.h"
#import "UIViewController+Additions.h"
#import "TabBar.h"
#import "TabBarItem.h"


typedef NS_ENUM(NSInteger,IBMTabBarIndex) {

    IBMTabBarHomeIndex   = 0,
    IBMTabBarFocusIndex  = 1,
    IBMTabBarMyIndex     = 2
    
};

@interface IBMRootViewController ()<TabBarDelegate,BRootViewControllerDelegate>{

    TabBar *_tabBar;
    
}

@end

@implementation IBMRootViewController

+(instancetype)sharedInstance{
    
    static IBMRootViewController *_instance = nil;
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
    
    //TODO load data
    
    _tabBar = [[TabBar alloc]initWithFrame:self.tabBar.bounds];
    _tabBar.delegate = self;
    [self loadTabBarItems];
    [self.tabBar addSubview:_tabBar];
    [self.view bringSubviewToFront:_tabBar];
    
    
    
}

-(void)loadTabBarViewController{
    
    IBMUserViewController *vc1 = IBMUserViewController.new;
    vc1.hidesBottomBarWhenPushed = YES;
    
    
}

- (void)didReceiveMemoryWarning{

    [super didReceiveMemoryWarning];
}

- (void)onRefreshComplete{

    
}


- (UINavigationController *)currentNavigationController{
    
    return self.viewControllers[self.selectedIndex];
}

- (UIViewController *)currentViewcontroller{
    
    UINavigationController *navigationController = [self currentNavigationController];
    UIViewController *viewController = [navigationController.viewControllers lastObject];
    return viewController;
    
}


- (void)loadTabBarItems{

    TabBarItem *tab1 = [self createTabBarItemAt:IBMTabBarHomeIndex];
    TabBarItem *tab2 = [self createTabBarItemAt:IBMTabBarFocusIndex];
    TabBarItem *tab3 = [self createTabBarItemAt:IBMTabBarMyIndex];
    _tabBar.tabBarItems = @[tab1,tab2,tab3];
}

- (TabBarItem *)createTabBarItemAt:(NSInteger)index{

    TabBarItem *tabBarItem = [[TabBarItem alloc] init];
    TabbarItemContent *itemContent = [[TabbarItemContent alloc] init];
    itemContent.index = index;
    itemContent.titleColor = [UIColor blackColor];
    switch (index) {
        case IBMTabBarHomeIndex:
            itemContent.title = @"首页";
            itemContent.normalImage = [UIImage imageNamed:@""];
            itemContent.highlightImage = [UIImage imageNamed:@""];
            itemContent.refreshImage = [UIImage imageNamed:@""];
            break;
        case IBMTabBarFocusIndex:
            itemContent.title = @"首页";
            itemContent.normalImage = [UIImage imageNamed:@""];
            itemContent.highlightImage = [UIImage imageNamed:@""];
            itemContent.refreshImage = [UIImage imageNamed:@""];
            break;
        case IBMTabBarMyIndex:
            itemContent.title = @"首页";
            itemContent.normalImage = [UIImage imageNamed:@""];
            itemContent.highlightImage = [UIImage imageNamed:@""];
            itemContent.refreshImage = [UIImage imageNamed:@""];
            break;
    }
    
    tabBarItem.tabBarItemContent = itemContent;
    return tabBarItem;
}

@end
