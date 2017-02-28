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
#import "IBMUserViewController.h"
#import "BaseNavigationController.h"
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
    
    [self loadTabBarViewControllers];
    
    _tabBar = [[TabBar alloc]initWithFrame:self.tabBar.bounds];
    _tabBar.delegate = self;
    [self loadTabBarItems];
    [self.tabBar addSubview:_tabBar];
    [self.view bringSubviewToFront:_tabBar];
    
    [_tabBar setTabBarSelectedIndex:IBMTabBarHomeIndex];
    
    [IBRequest requestWithPage:1 category:self.category success:^(NSArray<Meizi *> *meiziArray) {
        NSLog(@"requese success");
//        [self.collectionView.mj_header endRefreshing];
//        [self reloadDataWithMeiziArray:meiziArray emptyBeforeReload:YES];
    } failure:^(NSString *message) {
//        [SVProgressHUD showErrorWithStatus:message];
//        [self.collectionView.mj_header endRefreshing];
    }];

    
}

-(void)loadTabBarViewControllers{
    
    IBMUserViewController *vc1 = IBMUserViewController.new;
    vc1.hidesBottomBarWhenPushed = YES;
    [vc1 setNavigationBarTitle:@"首页"];
    BaseNavigationController *nav1 = [[BaseNavigationController alloc] initWithRootViewController:vc1];
    
    
    IBMUserViewController *vc2 = IBMUserViewController.new;
    vc2.hidesBottomBarWhenPushed = YES;
    [vc2 setNavigationBarTitle:@"副业"];
    BaseNavigationController *nav2 = [[BaseNavigationController alloc] initWithRootViewController:vc2];
    
    
    IBMUserViewController *vc3 = IBMUserViewController.new;
    vc3.hidesBottomBarWhenPushed = YES;
    [vc3 setNavigationBarTitle:@"三爷"];
    BaseNavigationController *nav3 = [[BaseNavigationController alloc] initWithRootViewController:vc3];
    
    
    self.viewControllers = @[nav1,nav2,nav3];
    
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
            itemContent.normalImage = [UIImage imageNamed:@"tabbar_home"];
            itemContent.highlightImage = [UIImage imageNamed:@"tabbar_home_HL"];
            itemContent.refreshImage = [UIImage imageNamed:@"tabbar_refresh"];
            break;
        case IBMTabBarFocusIndex:
            itemContent.title = @"首页2";
            itemContent.normalImage = [UIImage imageNamed:@"tabbar_focus"];
            itemContent.highlightImage = [UIImage imageNamed:@"tabbar_focus_HL"];
            break;
        case IBMTabBarMyIndex:
            itemContent.title = @"首页3";
            itemContent.normalImage = [UIImage imageNamed:@"tabbar_my"];
            itemContent.highlightImage = [UIImage imageNamed:@"tabbar_my_HL"];
            break;
    }
    
    tabBarItem.tabBarItemContent = itemContent;
    return tabBarItem;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(NSInteger )index{

    switch (index) {
        case IBMTabBarHomeIndex:
            //log
            break;
        case IBMTabBarFocusIndex:
            
            break;
        case IBMTabBarMyIndex:
            
            break;
        default:
            break;
    }
    
    if (index == self.selectedIndex) {
//        BaseNavigationController * naviVC =
    }
}

@end
