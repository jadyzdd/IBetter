//
//  UIViewController+Additions.m
//  Attributor
//
//  Created by jady on 2016/11/5.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "UIViewController+Additions.h"

@implementation UIViewController (Additions)

/**
 *  根据视觉的统一要求，返回按钮左边距为24px
 */
- (void)setLeftNaviBtnImage:(UIImage*)image target:(id)target action:(SEL)action{
    UIBarButtonItem *leftButtonItem = [UIBarButtonItem.alloc initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
    
    //修正边距的占位符
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    
    /**
     width为负数时，相当于btn向左移动width数值个像素
     */
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftButtonItem, nil];
    self.navigationItem.hidesBackButton = YES;
}

- (void)setRightNaviBtnImage:(UIImage*)image target:(id)target action:(SEL)action{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}


- (void)setLeftNaviBtnImageName:(NSString*)name target:(id)target action:(SEL)action {
    UIImage* image = [UIImage imageNamed:name];
    [self setLeftNaviBtnImage:image target:target action:action];
}

- (void)setRightNaviBtnImageName:(NSString*)name target:(id)target action:(SEL)action {
    UIImage* image = [UIImage imageNamed:name];
    [self setRightNaviBtnImage:image target:target action:action];
}

- (void)setLeftNaviBtnTitle:(NSString*)title target:(id)target action:(SEL)action {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem.alloc initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}

- (void)setRightNaviBtnTitle:(NSString*)title target:(id)target action:(SEL)action {
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}

- (void)setNavigationBarTitle:(NSString*)title {
    if ([self.navigationItem.titleView isKindOfClass:UILabel.class]) {
        [self.navigationItem.titleView performSelector:@selector(setText:) withObject:title];
        [self.navigationItem.titleView sizeToFit];
        return;
    }
    [self setNavigationBarTitle:title fontSize:18 textColor:[UIColor blackColor]];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:nil
                                                                            action:nil];
}

- (void)setNavigationBarTitle:(NSString*)title fontSize:(CGFloat)size textColor:(UIColor*)color {
    UILabel* label = (UILabel*)self.navigationItem.titleView;
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:size];
        label.textColor = color;
        label.userInteractionEnabled = YES;
        self.navigationItem.titleView = label;
    }
    if ([label respondsToSelector:@selector(setText:)]) {
        label.text = title;
    }
    [label sizeToFit];
}

@end
