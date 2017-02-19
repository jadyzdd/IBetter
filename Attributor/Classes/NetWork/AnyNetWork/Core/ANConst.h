//
//  ANConst.h
//  Attributor
//
//  Created by jady on 2017/2/10.
//  Copyright © 2017年 张栋栋. All rights reserved.
//

#ifndef AnyNetwork_ANConst_h
#define AnyNetwork_ANConst_h


#pragma mark - Enum

/**
 *  网络状态。
 */
typedef NS_ENUM(NSInteger, ANNetworkStatus){
    ANNetworkStatusNoNetwork = 1, //!< 无网络
    ANNetworkStatusCellular, //!< 蜂窝网络
    ANNetworkStatusWiFi, //!< WiFi网络
};

/**
 *  网络请求优先级枚举。
 */
typedef NS_ENUM(NSUInteger, ANRequestPriority) {
    ANRequestPriorityVeryLow = 1, //!< 最低
    ANRequestPriorityLow,         //!< 较低
    ANRequestPriorityNormal,      //!< 普通
    ANRequestPriorityHigh,        //!< 较高
    ANRequestPriorityVeryHigh,    //!< 最高
};

#endif
