//
//  BBaseViewControllers.m
//  Attributor
//
//  Created by jady on 2016/11/5.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "BBaseViewControllers.h"
#import "UIViewController+Additions.h"

NSString * const kHLNaviBarTintColor = @"HLNaviBarTintColor";
NSString * const kHLNaviBarHidden = @"HLNaviBarHidden";

// HLViewControllerProtocol parameter keys
NSString * const kHLPoppedVCParamFeedId     = @"HLPoppedVCParamFeedId";
NSString * const kHLPoppedVCParamFeedModel  = @"HLPoppedVCParamFeedModel";

@interface BBaseViewControllers() //<YJBaseNavigationBarDelegate>

//@property(nonatomic, strong) YSURLAction    *action;

@end

@implementation BBaseViewControllers


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        if ( IS_GE_IOS8 ) {
            self.navigationController.hidesBarsOnSwipe = YES;
            self.navigationController.hidesBarsOnTap = YES;
        }
        
    }
    return self;
}

- (id)initWithNavigatorURL:(NSURL *)URL query:(NSDictionary *)query{
    self = [self init];
    if (self) {
//        self.action = [[YSURLAction alloc]initWithURLStirng:URL.absoluteString params:query];
    }
    return self;
}

- (void) setNavigationBarTranscluent:(BOOL)transcluent
{
    self.navigationController.navigationBar.translucent = transcluent;
    if (transcluent == NO) {
        self.extendedLayoutIncludesOpaqueBars = YES;
    }
}
- (void) restoreNavigationBarTranscluent
{
    // Todo:
}

- (void) setNavigationBarColor:(UIColor *)color
{
    UIColor *previousColor = self.navigationController.navigationBar.barTintColor;
    if (previousColor) {
        [[[NSThread currentThread] threadDictionary] setObject:previousColor forKey:kHLNaviBarTintColor];
    }
    
    [self.navigationController.navigationBar setBarTintColor:color];
}

- (void) restoreNavigationBarColor
{
    UIColor *originalColor = [[[NSThread currentThread] threadDictionary] objectForKey:kHLNaviBarTintColor];
    if (originalColor) {
        [self.navigationController.navigationBar setBarTintColor:originalColor];
    }
}

- (void) showNavigationBar:(BOOL)show
{
    [self showNavigationBar:show animated:NO];
}

- (void) showNavigationBar:(BOOL)show animated:(BOOL)animated
{
    BOOL hidden = !show;
    [[[NSThread currentThread] threadDictionary] setObject:[NSNumber numberWithBool:!hidden] forKey:kHLNaviBarHidden];
//    [[ALANavigationAdapter sharedNavigationAdapter]setNavigationBarHidden:hidden animated:animated withContainer:self];
}

- (void) restoreNavigationBar
{
    NSNumber *obj = [[[NSThread currentThread] threadDictionary] objectForKey:kHLNaviBarHidden];
    if (obj) {
        BOOL hidden = [obj boolValue];
//        [[ALANavigationAdapter sharedNavigationAdapter]setNavigationBarHidden:hidden animated:YES withContainer:self];
    }
}

- (void) setShadowOfNavigationBar:(BOOL)show
{
    UIView *view = self.navigationController.navigationBar;
    if (show && view.layer.shadowOffset.height == -3) {
        //NaviBar加阴影
        view.layer.shadowOffset = CGSizeMake(0,0.5);//shadowOffset阴影偏移,y向下偏移0.5，默认(0, -3),这个跟shadowRadius配合使用
        view.layer.shadowOpacity = 0.2;//阴影透明度，默认0
        view.layer.shadowRadius = 0.6;//阴影半径，默认3
    } else if (!show && view.layer.shadowOffset.height != -3) {
        // 恢复默认值
        view.layer.shadowOffset = CGSizeMake(0, -3);
        view.layer.shadowOpacity = 0;
        view.layer.shadowRadius = 3;
    }
}

- (void) callPopBackDelegate
{
    
    if (self.hlVCDelegate && [self.hlVCDelegate respondsToSelector:@selector(onPopedViewController:params:)]) {
        [self.hlVCDelegate onPopedViewController:self params:[self onPoppedParams]];
    }

}

- (void)loadView{
    [super loadView];
    //Default Config
    self.view.backgroundColor = HL_BACKGROUND_COLOR;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [[[UTAnalytics getInstance] getDefaultTracker] pageAppear:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [[[UTAnalytics getInstance] getDefaultTracker] pageDisAppear:self];
    
    [self restoreNavigationBar];
    
    if ([self isBeingDismissed] || [self isMovingFromParentViewController]) {
        // 没有Native返回按钮, 基类ViewController中的返回按钮事件不能触发,返回按钮点击也会走到这
        [self onWillPopViewController];
        [self callPopBackDelegate];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self setNavigationBarColor:HL_WHITE_COLOR];
    [self setNavigationBarTranscluent:NO];
    // 默认关闭阴影,需要的子类可以选择开启
    [self setShadowOfNavigationBar:NO];
    
    if (self.hidesBottomBarWhenPushed) {
        UIImage *backImage = [UIImage imageNamed:@"back"];
        [self setLeftNaviBtnImage:backImage target:self action:@selector(onLeftNaviBtnHandler:)];
    }
    
//    [[HLFunctionsAdapter sharedInstance]addTaobaoCustomerMore:self];
    
    
}

#pragma mark - UI Event
- (void) onLeftNaviBtnHandler:(UIButton *)button{
//    [[ALANavigationAdapter sharedNavigationAdapter]popViewControllerAnimated:YES withContainer:self];
}
//
//- (void) onRightButtonHandler:(UIButton *)button{
//
//}

#pragma mark for override

- (NSDictionary *) onPoppedParams
{
    return nil;
}

- (void) onWillPopViewController
{
    // Do nothing
}


@end
