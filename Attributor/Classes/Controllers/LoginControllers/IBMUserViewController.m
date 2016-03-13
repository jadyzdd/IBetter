//
//  DSUserViewController.m
//  designboard
//
//  Created by mxc on 14/11/4.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "IBMUserViewController.h"


@interface IBMUserViewController ()

@property (strong, nonatomic) IBOutlet UITextView *tipView;

@end

@implementation IBMUserViewController

- (instancetype)init {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"tabboard"];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
{
    if (self = [self init]) {
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageLogName = @"mainViewLogout";
//    _tipView.textColor = [UIColor colorWithRGBHex:0xf18600];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toLogin:(id)sender {
//    DSScanViewController *scanVC = [[DSScanViewController alloc] initWithType:kDSScanTypeLogin];
//    scanVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:scanVC animated:YES];
}


@end
