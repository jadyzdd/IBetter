//
//  ViewController.h
//  Attributor
//
//  Created by jady on 2016/11/5.
//  Copyright © 2016年 张栋栋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBMViewControllerProtocol.h"
@interface ViewController : UIViewController

@property (nonatomic,assign) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;

@property (nonatomic,weak) id<IBMRootViewControllerProtocol> ibmRootProtocol;

@end
