//
//  UIView+Additions.h
//  Attributor
//
//  Created by jady on 2016/11/20.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UILayout) {
    UILayoutLT, // 左上角
    UILayoutLB, // 左下角
    UILayoutRT, // 右上角
    UILayoutRB, // 右下角
    UILayoutTHC,    // 向上水平对齐
    UILayoutBHC,    // 向下水平对齐
    UILayoutLVC,    // 向左垂直对齐
    UILayoutRVC,    // 向右垂直对齐
    UILayoutCenter, // 居中对齐
    UILayoutOutsideBHC,  // 外部向上水平对齐
    UILayoutOutsideTHC,  // 外部向上水平对齐
    UILayoutOutsideLVC, // 外部向上水平对齐
    UILayoutOutsideRVC   // 外部向上水平对齐
};

@interface UIView (Additions)

/**
 * Shortcut for frame.origin
 */
@property (nonatomic, assign) CGPoint origin;
@property(nonatomic, assign) CGFloat x;
@property(nonatomic, assign) CGFloat y;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;
@property(nonatomic, assign) CGSize size;

@property(nonatomic, assign) CGFloat left;
@property(nonatomic, assign) CGFloat right;
@property(nonatomic, assign) CGFloat top;
@property(nonatomic, assign) CGFloat bottom;
@property(nonatomic, assign) CGFloat centerX;
@property(nonatomic, assign) CGFloat centerY;
@property(nonatomic, readonly) CGPoint boundsCenter;

- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;

- (UIViewController*)viewController;

- (void)removeAllSubviews;

- (void)addTarget:(id)target onClick:(SEL)selector;
//- (void)addTarget:(id)target onPress:(SEL)selector;
//- (void)addTarget:(id)target onDoubleClick:(SEL)selector;


- (void)addSubview:(UIView*)view offset:(CGSize)size;
- (void)addSubview:(UIView*)view layout:(UILayout)layout offset:(CGSize)size;
- (void)layout:(UILayout)layout offset:(CGSize)size;
- (void)layout:(UILayout)layout offset:(CGSize)size inView:(UIView*)parent;

@end
