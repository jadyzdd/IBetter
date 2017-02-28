//
//  IBRequest.h
//  Attributor
//
//  Created by jady on 2017/2/20.
//  Copyright © 2017年 张栋栋. All rights reserved.
//

#import "SYBaseRequest.h"

@class Meizi;

typedef NS_ENUM(NSUInteger, MeiziCategory) {
    MeiziCategoryAll = 0,
    MeiziCategoryDaXiong,
    MeiziCategoryQiaoTun,
    MeiziCategoryHeisi,
    MeiziCategoryMeiTui,
    MeiziCategoryQingXin,
    MeiziCategoryZaHui
};

@interface IBRequest : SYBaseRequest

+ (IBRequest *)requestWithPage:(NSInteger)page
                      category:(MeiziCategory)category
                       success:(void (^)(NSArray<Meizi *> *meiziArray))success
                       failure:(void (^)(NSString *message))failure;

+ (NSArray<Meizi *> *)cachedMeiziArrayWithCategory:(MeiziCategory)category;

@end
