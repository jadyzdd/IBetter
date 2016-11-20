//
//  TabBarItem.h
//  Attributor
//
//  Created by jady on 2016/11/20.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BadgeView.h"


@interface TabbarItemContent : NSObject

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) UIImage *normalImage;
@property (nonatomic,strong) UIImage *highlightImage;
@property (nonatomic,strong) UIImage *refreshImage;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIColor *titleColor;

@end

@interface TabBarItem : UIButton

@property (nonatomic, strong) TabbarItemContent  *tabBarItemContent;
@property (nonatomic, strong) BadgeView          *badgeView;
@property (nonatomic, assign) BOOL               animationFlag;
@property (nonatomic, strong) UIImageView        *refreshView;

@end
