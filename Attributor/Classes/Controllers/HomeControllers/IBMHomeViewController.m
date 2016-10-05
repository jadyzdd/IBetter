//
//  IBMHomeViewController.m
//  Attributor
//
//  Created by 张栋栋 on 16/3/13.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "IBMHomeViewController.h"
#import "IBMUserViewController.h"


#define kDSScanNotificationLoginStateChanged @"kDSScanNotificationLoginSuccess"

typedef enum :NSUInteger{
    DSHomeViewTypeHomePage, //首页
    DSHomeViewTypeInspiration , //灵感
    DSHomeViewTypeSketch, //sketch
    DSHomeViewTypePs, //PS
    DSHomeViewTypeMy, //我的
} DSHomeViewType;


@interface IBMHomeViewController()<UITabBarDelegate>


@property (strong, nonatomic) UINavigationController *homePage;
@property (strong, nonatomic) UINavigationController *inspiration;
@property (strong, nonatomic) UINavigationController *sketch;
@property (strong, nonatomic) UINavigationController *ps;
@property (strong, nonatomic) UINavigationController *my;

@end

@implementation IBMHomeViewController


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (id)init {
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (mCOMMON_OS_7_OR_LATER) {
        self.tabBar.translucent = NO;
    }
    
    [self loadHome];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeLoginState:) name:kDSScanNotificationLoginStateChanged object:nil];
}

- (void)loadHome {
    
    _homePage = [self homePage];
    _inspiration = [self inspiration];
    _sketch = [self sketch];
    _ps = [self ps];
    _my = [self my];
    
    self.viewControllers = @[_homePage,_inspiration,_sketch,_ps,_my];
    
    [self _initTabble];
    
    [self setSelectedViewController:_homePage];
    
}

- (UINavigationController *)homePage{

    IBMUserViewController *homeVC = [[IBMUserViewController alloc] initWithTitle:@"科科"];
    
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    return homeNav;
}

- (UINavigationController *)inspiration{
    
    IBMUserViewController *moreVC = [[IBMUserViewController alloc] initWithTitle:@"呵呵"];
    
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:moreVC];
    
    return homeNav;
}

- (UINavigationController *)sketch{
    
    IBMUserViewController *moreVC = [[IBMUserViewController alloc] initWithTitle:@"呵呵"];
    
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:moreVC];
    
    return homeNav;
    
}

- (UINavigationController *)ps{
    IBMUserViewController *moreVC = [[IBMUserViewController alloc] initWithTitle:@"呵呵"];
    
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:moreVC];
    
    return homeNav;
}

- (UINavigationController *)my{
    
    IBMUserViewController *moreVC = [[IBMUserViewController alloc] initWithTitle:@"呵呵"];
    
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:moreVC];
    return homeNav;
}


- (void)_initTabble {
    
    self.tabBar.backgroundColor = [UIColor redColor];
    
    CGRect frame  = self.tabBar.frame;
    frame.origin.x = -2;
    frame.size.width = frame.size.width+4;
    self.tabBar.frame = frame;
    
    NSArray<UITabBarItem *> *tabbarItems = self.tabBar.items;
    UIOffset titleOffset = UIOffsetMake(0, -5);
    UIEdgeInsets imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
    
    
    UIColor *titleColor = mRGBColor(0, 0, 0);
    UIFont *titleFont  = [UIFont systemFontOfSize:10];
    
    NSDictionary *titleAttributesNormal = @{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont};
    //    NSDictionary *titleAttributeLighted = @{NSForegroundColorAttributeName:mRGBColor(0, 0, 0),NSFontAttributeName:titleFont};
    
    UITabBarItem *homeItem = tabbarItems[DSHomeViewTypeHomePage];
    homeItem.title = @"首页";
    homeItem.titlePositionAdjustment = titleOffset;
    homeItem.imageInsets = imageInsets;
    UIImage *homeImage = [[UIImage imageNamed:@"icon-home-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homeImagePressed = [[UIImage imageNamed:@"icon-home-pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeItem.image = homeImage;
    homeItem.selectedImage = homeImagePressed;
    [homeItem setTitleTextAttributes:titleAttributesNormal forState:UIControlStateNormal];
    //    [homeItem setTitleTextAttributes:titleAttributeLighted forState:UIControlStateHighlighted];
    
    
    UITabBarItem *inspirationItem = tabbarItems[DSHomeViewTypeInspiration];
    inspirationItem.title = @"灵感";
    inspirationItem.titlePositionAdjustment = titleOffset;
    inspirationItem.imageInsets = imageInsets;
    UIImage *inspirationImage = [[UIImage imageNamed:@"icon-insprise-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *inspirationImagePressed = [[UIImage imageNamed:@"icon-insprise-pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    inspirationItem.image = inspirationImage;
    inspirationItem.selectedImage = inspirationImagePressed;
    [inspirationItem setTitleTextAttributes:titleAttributesNormal forState:UIControlStateNormal];
    //    [inspirationItem setTitleTextAttributes:titleAttributeLighted forState:UIControlStateHighlighted];
    
    UITabBarItem *sketchItem = tabbarItems[DSHomeViewTypeSketch];
    sketchItem.title = @"sketch";
    sketchItem.titlePositionAdjustment = titleOffset;
    sketchItem.imageInsets = imageInsets;
    UIImage *sketchImage = [[UIImage imageNamed:@"icon-sketch-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *sketchImagePressed = [[UIImage imageNamed:@"icon-sketch-pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    sketchItem.image = sketchImage;
    sketchItem.selectedImage = sketchImagePressed;
    [sketchItem setTitleTextAttributes:titleAttributesNormal forState:UIControlStateNormal];
    //    [sketchItem setTitleTextAttributes:titleAttributeLighted forState:UIControlStateHighlighted];
    
    UITabBarItem *psItem = tabbarItems[DSHomeViewTypePs];
    psItem.title = @"PS";
    psItem.titlePositionAdjustment = titleOffset;
    psItem.imageInsets = imageInsets;
    UIImage *psImage = [[UIImage imageNamed:@"icon-ps-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *psImagePressed = [[UIImage imageNamed:@"icon-ps-pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    psItem.image = psImage;
    psItem.selectedImage = psImagePressed;
    [psItem setTitleTextAttributes:titleAttributesNormal forState:UIControlStateNormal];
    //    [psItem setTitleTextAttributes:titleAttributeLighted forState:UIControlStateHighlighted];
    
    UITabBarItem *myItem = tabbarItems[DSHomeViewTypeMy];
    myItem.title = @"我";
    myItem.titlePositionAdjustment = titleOffset;
    myItem.imageInsets = imageInsets;
    UIImage *myImage = [[UIImage imageNamed:@"icon-my-normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *myImagePressed = [[UIImage imageNamed:@"icon-my-pressed"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myItem.image = myImage;
    myItem.selectedImage = myImagePressed;
    [myItem setTitleTextAttributes:titleAttributesNormal forState:UIControlStateNormal];
    //    [myItem setTitleTextAttributes:titleAttributeLighted forState:UIControlStateHighlighted];
    
}

#pragma mark UITabBarDelegate

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    CATransition* animation = [CATransition animation];
    [animation setDuration:0.1f];
    [animation setType:kCATransitionFade];
    [animation setSubtype:kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [[self.view layer] addAnimation:animation forKey:@"switchView"];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


- (void)didChangeLoginState:(NSNotification *)notification
{
//    //切换登录状态时更换整个rootVC
//    NSDictionary *info = notification.userInfo;
//    NSString *state = @"login";
//    if (info) {
//        state = [info objectForKey:@"state"];
//    }
//    
//    
//    NSString *userId = [DSTokenService getAccount];
//    NSString *userName = [DSTokenService getName];
//    
//    if ([state isEqualToString:@"logout"]) {
//        
//        
//    }
//    else if (!userId||!userName) {
//        [[ChopeToastView toastViewWithMessage:@"获取身份信息错误,请稍候再试"] showWithDuration:1.5];
//        return;
//    }
//    
    [self loadHome];
}

@end
