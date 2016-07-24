//
//  IBMModel.m
//  Attributor
//
//  Created by 张栋栋 on 16/7/24.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "IBMModel.h"

@implementation IBMModel

+(NSString *)getTableName{

    return NSStringFromClass([self class]);
}

@end
