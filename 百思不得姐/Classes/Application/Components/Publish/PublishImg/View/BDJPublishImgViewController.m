//
//  BDJPublishImgViewController.m
//  百思不得姐
//
//  Created by Yizzuide on 2017/1/30.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "BDJPublishImgViewController.h"

@interface BDJPublishImgViewController ()

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@end

@implementation BDJPublishImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"发布";
    
}

- (IBAction)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
