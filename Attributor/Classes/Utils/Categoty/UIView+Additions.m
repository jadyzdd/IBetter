//
//  UIView+Additions.m
//  Attributor
//
//  Created by jady on 2016/11/20.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

#pragma mark - origin
- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
#pragma mark - x
- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
#pragma mark - y
- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
#pragma mark - width
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
#pragma mark - height
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
#pragma mark - Size
- (CGSize) size {
    return self.frame.size;
}
- (void) setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}
#pragma mark - left
- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}
#pragma mark - right
- (CGFloat)right {
    CGRect frame = self.frame;
    return frame.origin.x + frame.size.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
#pragma mark - top
- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}
#pragma mark - bottom
- (CGFloat)bottom {
    CGRect frame = self.frame;
    return frame.origin.y + frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
#pragma mark - centerX
- (CGFloat) centerX {
    return CGRectGetMidX(self.frame);
}
- (void) setCenterX:(CGFloat)centerX {
    CGRect frame = self.frame;
    frame.origin.x += (centerX - CGRectGetMidX(frame));
    self.frame = frame;
}
#pragma mark - centerY
- (CGFloat) centerY {
    return CGRectGetMidY(self.frame);
}
- (void) setCenterY:(CGFloat)centerY {
    CGRect frame = self.frame;
    frame.origin.y += (centerY - CGRectGetMidY(frame));
    self.frame = frame;
}
#pragma mark - boundsCenter
- (CGPoint) boundsCenter
{
    return CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
}

#pragma mark - init mehtods
- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height {
    if ((self = [self initWithFrame:CGRectMake(0, 0, width, height)]) == nil) {
        return nil;
    }
    return self;
}


#pragma mark - screenFrame
- (CGRect)screenFrame {
    CGRect frame = self.frame;
    for (UIView* view = self.superview; view != nil; view = view.superview) {
        frame.origin.x += view.left;
        frame.origin.y += view.top;
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            frame.origin.x -= scrollView.contentOffset.x;
            frame.origin.y -= scrollView.contentOffset.y;
        }
    }
    return frame;
}


#pragma mark - 根据UIView的superview查找UIViewController
- (UIViewController*)viewController {
    for (UIResponder* responder = [self nextResponder]; responder != nil; responder = [responder nextResponder]) {
        if ([responder isKindOfClass:UIViewController.class]) {
            return (UIViewController*)responder;
        }
    }
    return nil;
}

#pragma mark - 一键删除所有子视图
- (void)removeAllSubviews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

#pragma mark - 点击事件相关
- (void)addTarget:(id)target onClick:(SEL)selector {
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[UITapGestureRecognizer.alloc initWithTarget:target action:selector]];
}
//- (void)addTarget:(id)target onPress:(SEL)selector {
//    self.userInteractionEnabled = YES;
//    [self addGestureRecognizer:[UILongPressGestureRecognizer.alloc initWithTarget:target action:selector]];
//}
//- (void)addTarget:(id)target onDoubleClick:(SEL)selector {
//    self.userInteractionEnabled = YES;
//    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
//    tap.numberOfTapsRequired = 2;
//    [self addGestureRecognizer:tap];
//}

#pragma mark - 页面布局
- (void)addSubview:(UIView*)view offset:(CGSize)size {
    UIView* last = [self.subviews lastObject];
    if (last == nil) {
        view.x = size.width;
        view.y = size.height;
    } else {
        view.x = last.left + size.width;
        view.y = last.bottom + size.height;
    }
    [self addSubview:view];
}
- (void)addSubview:(UIView*)view layout:(UILayout)layout offset:(CGSize)size {
    [view layout:layout offset:size inView:self];
    [self addSubview:view];
}

- (void)layout:(UILayout)layout offset:(CGSize)size {
    [self layout:layout offset:size inView:self.superview];
}

- (void)layout:(UILayout)layout offset:(CGSize)size inView:(UIView*)parent {
    CGRect frame = parent.frame;
    CGRect newFrame = self.frame;
    switch (layout) {
        case UILayoutLT:{
            newFrame.origin = CGPointMake(size.width, size.height);
            break;
        }
        case UILayoutLB:{
            newFrame.origin = CGPointMake(size.width, frame.size.height - self.height - size.height);
            break;
        }
        case UILayoutRT:{
            newFrame.origin = CGPointMake(frame.size.width - self.width - size.width, size.height);
            break;
        }
        case UILayoutRB:{
            CGFloat x = frame.size.width - self.bounds.size.width - size.width;
            CGFloat y = frame.size.height - self.bounds.size.height - size.height;
            newFrame.origin = CGPointMake(x, y);
            break;
        }
        case UILayoutTHC:{
            newFrame.origin = CGPointMake((frame.size.width - self.bounds.size.width) / 2 + size.width, self.frame.origin.y + size.height);
            break;
        }
        case UILayoutBHC:{
            CGFloat x = (frame.size.width - self.bounds.size.width) / 2 + size.width;
            CGFloat y = frame.size.height - self.bounds.size.height - size.height;
            newFrame.origin = CGPointMake(x, y);
            break;
        }
        case UILayoutLVC:{
            newFrame.origin = CGPointMake(size.width, (frame.size.height - self.bounds.size.height) / 2 + size.height);
            break;
        }
        case UILayoutRVC:{
            CGFloat x = frame.size.width - self.bounds.size.width - size.width;
            CGFloat y = (frame.size.height - self.bounds.size.height) / 2 + size.height;
            newFrame.origin = CGPointMake(x, y);
            break;
        }
        case UILayoutCenter:{
            CGFloat x = (frame.size.width - self.bounds.size.width) / 2 + size.width;
            CGFloat y = (frame.size.height - self.bounds.size.height) / 2 + size.height;
            newFrame.origin = CGPointMake(x, y);
            break;
        }
        case UILayoutOutsideBHC:{
            CGFloat x = (frame.size.width - self.bounds.size.width) / 2 + size.width;
            CGFloat y = frame.size.height + size.height;
            newFrame.origin = CGPointMake(x, y);
            break;
        }
        case UILayoutOutsideTHC:{
            CGFloat x = (frame.size.width - self.bounds.size.width) / 2 + size.width;
            CGFloat y = 0 - self.bounds.size.height - size.height;
            newFrame.origin = CGPointMake(x, y);
            break;
        }
        case UILayoutOutsideLVC:{
            CGFloat x = 0 - self.bounds.size.width - size.width;
            CGFloat y = (frame.size.height - self.bounds.size.height) / 2 + size.height;
            newFrame.origin = CGPointMake(x, y);
            break;
        }
        case UILayoutOutsideRVC:{
            CGFloat x = frame.size.width + size.width;
            CGFloat y = (frame.size.height - self.bounds.size.height) / 2 + size.height;
            newFrame.origin = CGPointMake(x, y);
            break;
        }
    }
    self.frame = newFrame;
}

@end
