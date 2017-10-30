//
//  AppDelegate.m
//  Attributor
//
//  Created by 张栋栋 on 14-12-30.
//  Copyright (c) 2014年 张栋栋. All rights reserved.
//

#import "AppDelegate.h"
#import "IBMRootViewController.h"
#import "IBMHomeViewController.h"

#import <SMS_SDK/SMSSDK.h>


//SMSSDK官网公共key
#define mob_appkey @"189897e0de6dc"
#define mob_appSecrect @"1ea6703dbd2e3519ab403de92efe335d"

@interface AppDelegate ()

@end

@implementation AppDelegate

//test commit lalla agian agian
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL loginFlag = [user boolForKey:@"loginFlag"];
    NSString *userName = [user objectForKey:@"userName"];
    NSString *userPassword = [user objectForKey:@"userPassword"];
    //注册MOB短信验证
    [SMSSDK registerApp:mob_appkey withSecret:mob_appSecrect];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
//    if (!loginFlag) {
//        if (userName !=nil && userPassword != nil) {
//            [self ]
//        }
//    }
    
    _rootController = [[IBMRootViewController alloc] init];
    _homeController = [[IBMHomeViewController alloc] init];
    self.window.rootViewController = _rootController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


//- (void)showLogin{
//    VCLogin *vc = [[VCLogin alloc]init];
//    VCNavBase *nvc = [[VCNavBase alloc]initWithRootViewController:vc];
//    self.window.rootViewController = nvc;
//}


- (BOOL)isFirstLaunch{
//    id firstLaunch = [CMStorageService ud_objectForKey:PM_APP_FIRST_LAUNCH];
//    if (firstLaunch && [firstLaunch isKindOfClass:[NSNumber class]]) {
//        return [((NSNumber *)firstLaunch) boolValue];
//    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
