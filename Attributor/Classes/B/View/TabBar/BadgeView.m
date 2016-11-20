//
//  BadgeView.m
//  Attributor
//
//  Created by jady on 2016/11/20.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "BadgeView.h"

@implementation BadgeView

- (instancetype) initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.textColor = [UIColor whiteColor];
        self.font = [UIFont systemFontOfSize:10];
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.adjustsFontSizeToFitWidth  = YES;
        self.hidden = YES;
    }
    return self;
}


- (void)setNumber:(NSInteger)number{

    _number = number;
    if (_number > 0) {
        NSString *text = _number > 99 ? @"99" : [NSString stringWithFormat:@"%ld", _number];
        [self setText:text];
        [self sizeToFit];
        CGRect frame = self.frame;
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width + 6, frame.size.height);
        self.hidden = NO;
    }else{
    
        self.hidden = YES;
    }
    
    self.layer.cornerRadius = self.frame.size.height * 0.5;
}
@end
