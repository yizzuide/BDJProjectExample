//
//  XMGNavigationController.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/11.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGNavigationController.h"

@interface XMGNavigationController ()

@end

@implementation XMGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationBar setBackgroundImage:[UIImage imageNamed:R_Image_NavBkg] forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
