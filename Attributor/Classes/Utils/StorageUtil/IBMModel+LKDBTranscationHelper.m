////
////  IBMModel+LKDBTranscationHelper.m
////  Attributor
////
////  Created by 张栋栋 on 16/7/24.
////  Copyright © 2016年 张栋栋. All rights reserved.
////
//
//#import "IBMModel+LKDBTranscationHelper.h"
//#import "LKDBTranscationHelper.h"
//
//@implementation IBMModel(LKDBTranscationHelper)
//
//
//+(void)dbDidCreateTable:(LKDBTranscationHelper *)helper{}
//
//
//#pragma mark - simplify synchronous function
//+(BOOL)checkModelClass:(IBMModel*)model
//{
//    if([model isMemberOfClass:self])
//        return YES;
//    
//    NSLog(@"%@ can not use %@",NSStringFromClass(self),NSStringFromClass(model.class));
//    return NO;
//}
//
//+(int)rowCount{
//    return [[self getUsingLKDBHelper] rowCount:self where:nil];
//}
//+(NSMutableArray*)searchWithWhere:(id)where{
//    return [[self getUsingLKDBHelper] search:self where:where orderBy:nil offset:0 count:0];
//    
//}
//+(NSMutableArray*)searchWithWhere:(id)where orderBy:(NSString*)orderBy{
//    return [[self getUsingLKDBHelper] search:self where:where orderBy:orderBy offset:0 count:0];
//    
//}
//
//@end
