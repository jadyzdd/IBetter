//
//  CommonViewStyle.h
//  Attributor
//
//  Created by jady on 2017/3/1.
//  Copyright © 2017年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HL_BACKGROUND_COLOR     ColorWithRGB(0xf8f8f8)  //背景色

#define HL_DESIGN_WIDTH         375.0
#define HL_DESIGN_HEIGHT        667.f

#define HL_THEME_COLOR          ColorWithRGB(0xfdd500)  //黄色
#define HL_WHITE_COLOR          [UIColor whiteColor]


@interface CommonViewStyle : NSObject

@property (nonatomic,assign)CGFloat scala;

+ (instancetype)shareInstance;

- (void)initViewStyle;

+ (UIFont *)fontWithBold:(BOOL)isBold size:(CGFloat)size;

@end
