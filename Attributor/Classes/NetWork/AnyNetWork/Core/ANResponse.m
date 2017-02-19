//
//  ANResponse.m
//  Attributor
//
//  Created by jady on 2017/2/10.
//  Copyright © 2017年 张栋栋. All rights reserved.
//

#import "ANResponse.h"

@implementation ANResponse

- (instancetype) initWithInfo:(NSDictionary *)info{

    if (self = [super init]) {
        self.responseInfo = info;
    }
    
    return self;
}

@end
