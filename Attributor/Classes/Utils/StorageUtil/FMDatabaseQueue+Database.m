//
//  FMDatabaseQueue+Database.m
//  Attributor
//
//  Created by 张栋栋 on 16/8/1.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "FMDatabaseQueue+Database.h"

#import "FMDatabase.h"

@implementation FMDatabaseQueue(Database)

-(FMDatabase *)getDatabase{
#if DEBUG
    _db.traceExecution = NO; // close trace
#endif
    return _db;
}

@end
