//
//  IBRequest.m
//  Attributor
//
//  Created by jady on 2017/2/20.
//  Copyright © 2017年 张栋栋. All rights reserved.
//

#import "IBRequest.h"
#import "MJExtension.h"
#import "Meizi.h"

@interface IBRequest()

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) MeiziCategory category;

@end

@implementation IBRequest

- (instancetype)initWithPage:(NSInteger)page category:(MeiziCategory)category {
    self = [super init];
    if (self) {
        self.page = page;
        self.category = category;
    }
    return self;
}

+ (IBRequest *)requestWithPage:(NSInteger)page category:(MeiziCategory)category success:(void (^)(NSArray<Meizi *> *))success failure:(void (^)(NSString *))failure {
    IBRequest *request = [[IBRequest alloc] initWithPage:page category:category];
    [request startWithBlockSuccess:^(__kindof SYBaseRequest *request) {
        success?success(((IBRequest *)request).meiziArray):nil;
    } failure:^(__kindof SYBaseRequest *request, NSError *error) {
        failure?failure(error.localizedDescription):nil;
    }];
    return request;
}

- (BOOL)enableCache {
    return (self.page == 1)?YES:NO;
}

- (SYRequestMethod)requestMethod {
    return SYRequestMethodGET;
}

- (NSString *)baseURL {
    return @"https://meizi.leanapp.cn";
}

- (NSString *)requestPath {
    NSString *category = @"";
    switch (self.category) {
        case MeiziCategoryAll:
            category = @"All";
            break;
        case MeiziCategoryDaXiong:
            category = @"DaXiong";
            break;
        case MeiziCategoryQiaoTun:
            category = @"QiaoTun";
            break;
        case MeiziCategoryHeisi:
            category = @"HeiSi";
            break;
        case MeiziCategoryMeiTui:
            category = @"MeiTui";
            break;
        case MeiziCategoryQingXin:
            category = @"QingXin";
            break;
        case MeiziCategoryZaHui:
            category = @"ZaHui";
            break;
        default:
            category = @"All";
            break;
    }
    return [NSString stringWithFormat:@"/category/%@/page/%@", category, @(self.page)];
}

- (NSArray<Meizi *> *)meiziArray {
    return [Meizi mj_objectArrayWithKeyValuesArray:self.responseJSONObject[@"results"]];
}

+ (NSArray<Meizi *> *)cachedMeiziArrayWithCategory:(MeiziCategory)category {
    IBRequest *request = [[IBRequest alloc] initWithPage:1 category:category];
    return [Meizi mj_objectArrayWithKeyValuesArray:request.cacheJSONObject[@"results"]];
}

@end

