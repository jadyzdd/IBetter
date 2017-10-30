//
//  Constants.h
//  Attributor
//
//  Created by 张栋栋 on 16/3/13.
//  Copyright © 2016年 张栋栋. All rights reserved.
//



extern NSString *const kPageNameHomePage;
extern NSString *const kPageNameInspiration;
extern NSString *const kPageNameSketch;
extern NSString *const kPageNamePs;
extern NSString *const kPageNameMy;

@interface Constants : NSObject

@end

#define DEVICEWIDTH [UIScreen mainScreen].bounds.size.width
#define DEVICEHEIGHT [UIScreen mainScreen].bounds.size.height
#define RATIO_WIDHT320 [UIScreen mainScreen].bounds.size.width/320.0
#define RATIO_HEIGHT568 [UIScreen mainScreen].bounds.size.height/568.0


#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1)
#define RGB3(v) RGB(v,v,v)
#define BASE_COLOR RGB(4, 175, 255)
#define randomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))



#define SERVER_HOST @"https://designboard.alibaba-inc.com" //线上
#define SERVER_HOST_DAILY @"http://designboard.dev.fed.taobao.net" //日常

#define TOCKEN @"a45cdc1e68cff375c3aed5eea7376208"


#define SSO_KEY_CHAIN_PREFIX @"LQ38NAVXP6"
#define APP_ID @"designboard"
#define PRODUCT_NAME @"设计版"
#define PRODUCT_BUNDLE_IDENTIFIER [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define PRODUCT_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define PRODUCT_SHORT_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define PM_APP_FIRST_LAUNCH @"PM_APP_FIRST_LAUNCH"
//#define PMFontNameFZBYFKS @"FZBoYaFangKanSongK"
#define TTID [NSString stringWithFormat:@"201200@paimai_iphone_%@",PRODUCT_VERSION]

//登出时 可以在viewController中监听清空页面的数据
#define kPMLOGIN_NOTIFY_LOGOUT @"NOTIFY_NEED_LOGOUT"

// 判断系统版本
#define mCOMMON_OS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define mCOMMON_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define mCOMMON_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define mCOMMON_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define mCOMMON_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define mCOMMON_OS_4_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
#define mCOMMON_OS_3_2_OR_LATER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 3.2)
#define mCOMMON_OS_6_BEFORE      ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0)
#define mCOMMON_OS_7_BEFORE      ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
#define mCOMMON_OS_VERSION       ([[[UIDevice currentDevice] systemVersion] floatValue])

#define SYSTEM_VERSION_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)



// end定义页面名称

#define mRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
//顶部导航栏的颜色 也是app的主色调

#define mMainBgColor mRGBColor(220,220,220)

// 用于右对齐, 计算 Rect 大小及 x 轴位置
/**
 * view,padding,y,w,h
 */
#define mRightRectMake(view,padding,y,w,h) CGRectMake((view.bounds.size.width) - (padding) - (w), (y), (w), (h))

// 用于右对齐, 计算 Rect 大小及 x 轴位置
#define mRightRectMakeGivenViewWidth(viewWidth,padding,y,w,h) CGRectMake(viewWidth - (padding) - (w), (y), (w), (h))

// 屏幕尺寸
#define mScreenWidth [UIScreen mainScreen].bounds.size.width
#define mScreenHeight [UIScreen mainScreen].bounds.size.height

#define mCentralizeSmallerView(lager, smaller) (lager - smaller) /2

#define mApplicationWidth [UIScreen mainScreen].applicationFrame.size.width
#define mApplicationHeight [UIScreen mainScreen].applicationFrame.size.height
// 组件高度
#define mStatusBarHeight 20
#define mNavigationBarHeight 44
#define mTabBarHeight 49
// 视图坐标和尺寸
#define mViewX(view) (view.frame.origin.x)
#define mViewY(view) (view.frame.origin.y)
#define mViewW(view) (view.bounds.size.width)
#define mViewH(view) (view.bounds.size.height)
// Log
#ifdef DEBUG
#else
#   define NSLog( s, ... )
#endif

#define SCREEN_SMALL_THAN_IPHON4 ([UIScreen mainScreen].bounds.size.height <= 480)


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_SCALE ([[UIScreen mainScreen] scale])

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_WIDTH == 320.0 && SCREEN_HEIGHT == 480.0 && SCREEN_SCALE <= 2.0)

#ifdef IS_IPHONE_5
#undef IS_IPHONE_5
#endif
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_WIDTH == 320.0 && SCREEN_HEIGHT == 568.0 && SCREEN_SCALE == 2.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_WIDTH == 375.0 && SCREEN_HEIGHT == 667.0 && SCREEN_SCALE == 2.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_WIDTH == 414.0 && SCREEN_HEIGHT == 736.0 && SCREEN_SCALE == 3.0)

typedef void (^DSFailureBlock)(NSError *error);
