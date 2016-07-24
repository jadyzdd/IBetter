//
//  LKDBUtils.h
//  Attributor
//
//  Created by 张栋栋 on 16/7/24.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKDBUtils:NSObject
//返回根目录路径 "document"
+(NSString*) getDocumentPath;
//返回 "document/dir/" 文件夹路径
+(NSString*) getDirectoryForDocuments:(NSString*) dir;
//返回 "document/filename" 路径
+(NSString*) getPathForDocuments:(NSString*)filename;
//返回 "document/dir/filename" 路径
+(NSString*) getPathForDocuments:(NSString *)filename inDir:(NSString*)dir;
//文件是否存在
+(BOOL) isFileExists:(NSString*)filepath;
//删除文件
+(BOOL)deleteWithFilepath:(NSString*)filepath;
//返回该文件目录下 所有文件名
+(NSArray*)getFilenamesWithDir:(NSString*)dir;

//检测字符串是否为空
+(BOOL)checkStringIsEmpty:(NSString *)string;
//把Date 转换成String
+(NSString*)stringWithDate:(NSDate*)date;
//把String 转换成Date
+(NSDate *)dateWithString:(NSString *)str;
@end

