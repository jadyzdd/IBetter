//
//  ANResponse.h
//  Attributor
//
//  Created by jady on 2017/2/10.
//  Copyright © 2017年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANResponse : NSObject

- (instancetype)initWithInfo:(NSDictionary *)info;

@property (nonatomic, copy) NSDictionary *responseInfo;

@end
