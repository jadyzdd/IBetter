//
//  ANError.h
//  Attributor
//
//  Created by jady on 2017/2/10.
//  Copyright © 2017年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络错误。错误的解析与具体业务相关，此处只定义一个格式，使用时需要根据业务进行解析。
 */
@interface ANError : NSObject

/**
 *  错误的名称。一般应为对错误的非常简短的描述。
 */
@property (nonatomic, copy) NSString *name;

/**
 *  错误的细节。一般应为对错误的详细描述。
 */
@property (nonatomic, copy) NSString *detail;

/**
 *  错误码。一般应为业务自己定义的错误标识码，便于区分和查找。
 */
@property (nonatomic, assign) NSInteger code;

/**
 *  错误附加信息。一般应将附加信息放入其中。
 */
@property (nonatomic, copy) NSDictionary *info;

@end
