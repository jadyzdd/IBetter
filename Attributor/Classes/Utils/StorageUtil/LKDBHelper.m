//
//  LKDBHelper.m
//  Attributor
//
//  Created by 张栋栋 on 16/7/24.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "LKDBHelper.h"


@interface  LKDBHelper()

@property(strong,nonatomic)NSRecursiveLock *threadLock;
@property(copy,nonatomic)NSString *dbname;

@end

@implementation LKDBHelper

- (instancetype)initWithDBName:(NSString *)dbname{

    self = [super init];
    if (self) {
        self.threadLock = [[NSRecursiveLock alloc] init];
        [self setDBName:dbname];
    }
    return self;
}


- (instancetype)init{

    self = [super init];
    if (self) {
        self.threadLock = [[NSRecursiveLock alloc] init];
        [self setDBName:IBM_SQLITE_DB_NAME];
    }
    return self;
}


-(void)setDBName:(NSString *)fileName
{
    if([self.dbname isEqualToString:fileName] == NO)
    {
        if([fileName hasSuffix:@".db"] == NO)
        {
            self.dbname = [NSString stringWithFormat:@"%@.db",fileName];
        }
        else
        {
            self.dbname = fileName;
        }
        [self.bindingQueue close];
        self.bindingQueue = [[FMDatabaseQueue alloc]initWithPath:[LKDBUtils getPathForDocuments:self.dbname inDir:@"db"]];
        
#ifdef DEBUG
        //debug 模式下  打印错误日志
        [_bindingQueue inDatabase:^(FMDatabase *db) {
            db.logsErrors = YES;
        }];
#endif
        self.tableManager = [[LKTableManager alloc]initWithLKDBHelper:self];
    }
}

@end
