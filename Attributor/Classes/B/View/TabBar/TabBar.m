//
//  TabBar.m
//  Attributor
//
//  Created by jady on 2016/11/20.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "TabBar.h"

@implementation TabBar

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.opaque = YES;
    }
    return self;
}



- (void)layoutSubviews{

    [super layoutSubviews];
    
    CGFloat itemX = 0 ;
    CGFloat itemWidth = SCREEN_WIDTH/_tabBarItems.count;
    CGFloat itemHeight = self.bounds.size.height;
    
    for (int i = 0 ; i <_tabBarItems.count; i++) {
        TabBarItem *tabBarItem = _tabBarItems[i];
        tabBarItem.frame = CGRectMake(itemX, 0, itemWidth, itemHeight);
        [tabBarItem addTarget:self action:@selector(tabBarItemSelectHandler:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:tabBarItem];
        itemX += itemWidth;
    }
}

- (void)tabBarItemSelectHandler:(TabBarItem *)tabBarItem{

    NSInteger index = [_tabBarItems indexOfObject:tabBarItem];
    [self setTabBarSelectedIndex:index];
    if (_delegate && [_delegate respondsToSelector:@selector(tabBar:didSelectAtIndex:)]) {
        [_delegate tabBar:self didSelectAtIndex:index];
    }
}

- (void)setTabBarSelectedIndex:(NSInteger)index{

    [self setTabBarItemsSelectedIndex:[[self tabBarItems] objectAtIndex:(NSInteger)index]];
    self.currentIndex = index;
}



- (void)setTabBarItemsSelectedIndex:(TabBarItem *)tabBarItem{

    [_tabBarItems enumerateObjectsUsingBlock:^(TabBarItem *tabBarItem , NSUInteger idx, BOOL *stop) {
        [tabBarItem setSelected:NO];
        [tabBarItem setTitleColor:tabBarItem.tabBarItemContent.titleColor forState:UIControlStateNormal];
    }];
    
    [tabBarItem setTitleColor:tabBarItem.tabBarItemContent.titleColor forState:UIControlStateNormal];
    [tabBarItem setSelected:YES];
}

- (TabBarItem *)tabBarItemAtIndex:(NSInteger)index{

    for (TabBarItem *tabBarItem in _tabBarItems) {
        if (tabBarItem.tabBarItemContent.index == index) {
            return tabBarItem;
        }
    }
    return nil;
}


@end
