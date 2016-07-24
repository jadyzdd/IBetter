//
//  LKDBHelper.h
//  Attributor
//
//  Created by 张栋栋 on 16/7/24.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "IBMModel.h"


#define IBM_SQLITE_DB_NAME @"IBMCore"

@interface LKDBHelper : IBMModel

// you can use [LKDBHelper getUsingLKDBHelper]
//+(LKDBHelper*)sharedDBHelper;

-(id)initWithDBName:(NSString*)dbname;

/**
 *	@brief  change database , filepath the use of : "documents/db/" + fileName + ".db"
 */
-(void)setDBName:(NSString*)fileName;

/**
 *	@brief  execute database operations synchronously,not afraid of recursive deadlock  同步执行数据库操作 可递归调用
 */
-(void)executeDB:(void (^)(FMDatabase *db))block;

-(BOOL)executeSQL:(NSString *)sql arguments:(NSArray *)args;
-(NSString *)executeScalarWithSQL:(NSString *)sql arguments:(NSArray *)args;
@end

@interface LKDBHelper(DatabaseManager)

//create table with entity class
-(BOOL)createTableWithModelClass:(Class)model;

//drop all table
-(void)dropAllTable;

//drop table with entity class
-(BOOL)dropTableWithClass:(Class)modelClass;


@end

@interface LKDBHelper(DatabaseExecute)
/**
 *	@brief	The number of rows query table
 *
 *	@param 	modelClass      entity class
 *	@param 	where           can use NSString or NSDictionary or nil
 *
 *	@return	rows number
 */
-(int)rowCount:(Class)modelClass where:(id)where;
-(void)rowCount:(Class)modelClass where:(id)where callback:(void(^)(int rowCount))callback;

/**
 *	@brief	query table
 *
 *	@param 	modelClass      entity class
 *	@param 	where           can use NSString or NSDictionary or nil
 
 *	@param 	orderBy         The Sort: Ascending "name asc",Descending "name desc"
 For example: @"rowid desc"  or @"rowid asc"
 
 *	@param 	offset          Skip how many rows
 *	@param 	count           Limit the number
 *
 *	@return	query finished result is an array(model instance collection)
 */
-(NSMutableArray*)search:(Class)modelClass where:(id)where orderBy:(NSString*)orderBy offset:(int)offset count:(int)count;
-(void)search:(Class)modelClass where:(id)where orderBy:(NSString*)orderBy offset:(int)offset count:(int)count callback:(void(^)(NSMutableArray* array))block;
//return first model or nil
-(id)searchSingle:(Class)modelClass where:(id)where orderBy:(NSString*)orderBy;

/**
 *	@brief	insert table
 *
 *	@param 	model 	you want to insert the entity
 *
 *	@return	the inserted was successful
 */
-(BOOL)insertToDB:(IBMModel*)model;
-(void)insertToDB:(IBMModel*)model callback:(void(^)(BOOL result))block;

/**
 *	@brief	insert when the entity primary key does not exist
 *
 *	@param 	model 	you want to insert the entity
 *
 *	@return	the inserted was successful
 */
-(BOOL)insertWhenNotExists:(IBMModel*)model;
-(void)insertWhenNotExists:(IBMModel*)model callback:(void(^)(BOOL result))block;

/**
 *	@brief update table
 *
 *	@param 	model 	you want to update the entity
 *	@param 	where 	can use NSString or NSDictionary or nil
 when "where" is nil : update the value based on rowid colume or primary key colume
 *
 *	@return	the updated was successful
 */
-(BOOL)updateToDB:(IBMModel *)model where:(id)where;
-(void)updateToDB:(IBMModel *)model where:(id)where callback:(void (^)(BOOL result))block;
-(BOOL)updateToDB:(Class)modelClass set:(NSString*)sets where:(id)where;
/**
 *	@brief	delete table
 *
 *	@param 	model 	you want to delete entity
 when entity property "rowid" == 0  based on the primary key to delete
 *
 *	@return	the deleted was successful
 */
-(BOOL)deleteToDB:(IBMModel*)model;
-(void)deleteToDB:(IBMModel*)model callback:(void(^)(BOOL result))block;

/**
 *	@brief	delete table with "where" constraint
 *
 *	@param 	modelClass      entity class
 *	@param 	where           can use NSString or NSDictionary,  can not is nil
 *
 *	@return	the deleted was successful
 */
-(BOOL)deleteWithClass:(Class)modelClass where:(id)where;
-(void)deleteWithClass:(Class)modelClass where:(id)where callback:(void (^)(BOOL result))block;

/**
 *	@brief   entity exists?
 *           for primary key colume
 （if rowid > 0 would certainly exist so we do not rowid judgment）
 *	@param 	model 	entity
 *
 *	@return	YES: entity presence , NO: entity not exist
 */
-(BOOL)isExistsModel:(IBMModel*)model;
-(BOOL)isExistsClass:(Class)modelClass where:(id)where;


/**
 *	@brief	Clear data based on the entity class
 *
 *	@param 	modelClass 	entity class
 */
+(void)clearTableData:(Class)modelClass;

/**
 *	@brief	Clear Unused Data File
 if you property has UIImage or NSData, will save their data in the (documents dir)
 *
 *	@param 	modelClass      entity class
 *	@param 	columes         UIImage or NSData Colume Name
 */
+(void)clearNoneImage:(Class)modelClass columes:(NSArray*)columes;
+(void)clearNoneData:(Class)modelClass columes:(NSArray*)columes;

@end
