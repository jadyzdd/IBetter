//
//  TabBar.h
//  Attributor
//
//  Created by jady on 2016/11/20.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TabBarItem.h"

@protocol  TabBarDelegate;


@interface TabBar : UIView

@property (nonatomic,weak)id<TabBarDelegate> delegate;
@property (nonatomic, strong) NSArray *tabBarItems;
@property (nonatomic, assign) NSInteger currentIndex;

- (void) setTabBarSelectedIndex: (NSInteger) index;

- (TabBarItem *) tabBarItemAtIndex: (NSInteger) index;

@end

@protocol  TabBarDelegate <NSObject>

- (void) tabBar:(TabBar *)tabBar didSelectItem:(NSInteger )item;

@end
