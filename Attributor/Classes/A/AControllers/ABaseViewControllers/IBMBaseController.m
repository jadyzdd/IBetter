//
//  IBMBaseController.m
//  Attributor
//
//  Created by 张栋栋 on 16/3/13.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import "IBMBaseController.h"


@interface IBMBaseController()

@end

@implementation IBMBaseController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [DSLogService pageEnter:_pageLogName];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [DSLogService pageLeave:_pageLogName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
