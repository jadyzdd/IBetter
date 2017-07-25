//
//  DSUserViewController.m
//  designboard
//
//  Created by mxc on 14/11/4.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "IBMUserViewController.h"
#import "HHNormalAPIManager.h"


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
    [self normalRequest];
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


- (void)normalRequest {
    
    [[HHNormalAPIManager new] fetchNearLiveListWithUserId:133825214 isWomen:YES completionHandler:^(NSError *error, id result) {
        if (!error) {
            
            for (NSString *live in result) {
                NSLog(@"%@", live);
            }
        } else {
            
            //            switch (error.code) {
            //                case <#constant#>:
            //                    <#statements#>
            //                    break;
            //
            //                default:
            //                    break;
            //            }
        }
    }];
}


@end
