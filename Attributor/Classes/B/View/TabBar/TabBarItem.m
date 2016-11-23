//
//  TabBarItem.m
//  Attributor
//
//  Created by jady on 2016/11/20.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "TabBarItem.h"
#import "UIView+Additions.h"

@implementation TabbarItemContent

@end

@implementation TabBarItem

- (instancetype) initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self initBarItem];
    }
    return self;
}


- (void)initBarItem{

    self.titleLabel.font = [UIFont systemFontOfSize:10];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:({
        _badgeView = [[BadgeView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
        _badgeView.number = 0;
        _badgeView;
    }) layout:UILayoutRT offset:CGSizeMake(60, 6)];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void) setTabBarItemContent:(TabbarItemContent *)tabBarItemContent{
    if (tabBarItemContent) {
        _tabBarItemContent = tabBarItemContent;
        [self setImage:tabBarItemContent.normalImage forState:UIControlStateNormal];
        [self setImage:tabBarItemContent.highlightImage forState:UIControlStateSelected];
        [self setTitle:tabBarItemContent.title forState:UIControlStateNormal];
    }
}

- (void) layoutSubviews{

    [super layoutSubviews];
    [self layoutImageTitle];
}

- (void) layoutImageTitle{

    self.titleEdgeInsets = UIEdgeInsetsMake(36, - 6.2f, 3, 18);
    CGFloat padding = (self.frame.size.width - 24) *2.5;
    self.imageEdgeInsets = UIEdgeInsetsMake(5, padding, 15, padding);
    CGRect badgeframe = _badgeView.frame;
    badgeframe.origin = CGPointMake((self.frame.size.width)*0.5 +4 , 5);
    _badgeView.frame = badgeframe;
}

- (void)setAnimationFlag:(BOOL)animationFlag{

    _animationFlag = animationFlag;
    
    if (animationFlag) {
        [self setImage:self.tabBarItemContent.refreshImage forState:UIControlStateNormal];
        [self setImage:self.tabBarItemContent.refreshImage forState:UIControlStateSelected];
        [self rotareView:self.imageView];
    }else{
    
        [self.imageView.layer removeAllAnimations];
        self.imageView.transform = CGAffineTransformIdentity;
        
        TabbarItemContent *itemContent = self.tabBarItemContent;
        [self setImage:itemContent.normalImage forState:UIControlStateNormal];
        [self setImage:itemContent.highlightImage forState:UIControlStateSelected];
    }
}





- (void)rotareView:(UIView *)view{

    [UIView animateWithDuration:.6 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [view setTransform:CGAffineTransformRotate(view.transform, M_PI)];
    } completion:^(BOOL finished) {
        [self rotareView:view];
    }];
}


@end
