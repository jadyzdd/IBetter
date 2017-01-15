//
//  AppMacros.h
//  Attributor
//
//  Created by jady on 2016/11/23.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#ifndef AppMacros_h
#define AppMacros_h

#define kStatusBarHeight    (20)
#define kNaviBarHeight      (64)
#define kNaviBarOnlyHeight  (44)
#define kTabBarHeight       (44)

#define kUserDefaultsGuideView  @"guideView"

#define SCREEN_HEIGHT       ((float)[[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH        ((float)[[UIScreen mainScreen] bounds].size.width)

#define IS_GE_IPHONE4       (SCREEN_HEIGHT >= 480)  //w320,h480
#define IS_GE_IPHONE5       (SCREEN_HEIGHT >= 568)  //w320,h568
#define IS_GE_IPHONE6       (SCREEN_HEIGHT >= 667)  //w375,h667
#define IS_GE_IPHONE6PLUS   (SCREEN_HEIGHT >= 736)  //w414,h736

#define IS_GE_IOS7          ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_GE_IOS8          ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_LE_IOS8          ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)

#define ColorWithRGBA(rgb, a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16)) / 255.0 \
green:((float)((rgb & 0x00FF00) >> 8 )) / 255.0 \
blue:((float)((rgb & 0x0000FF) >> 0 )) / 255.0 \
alpha:a]
#define ColorWithRGB(rgb) ColorWithRGBA(rgb, 1.0)

#define PathForBundleResource(bundleName, resourceName, resourceType) \
[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"]] pathForResource:resourceName ofType:resourceType]

#define PathForBundleResourcePNG(resourceName) PathForBundleResource(resourceName, @"png")
#define PathForMainBundleResourcePNG(resourceName) [[NSBundle mainBundle] pathForResource:resourceName ofType:@"png"]
#define LoadPNG(resourceName) [UIImage imageWithContentsOfFile:PathForMainBundleResourcePNG(resourceName)]

#define WeakSelf(weakSelf)          __weak __typeof (&*self) weakSelf = self;
#define StrongSelf(wself, sself)    __strong __typeof (&*wself) sself = wself;


//safe array
#define SafeArrayObjectAtIndex(array, index) (array.count>index ? array[index] : nil)


//dispatch_main_sync
#ifndef dispatch_main_sync_safe
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

#endif /* AppMacros_h */
