//
//  BDJSignInViewController.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/17.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJSignInViewController.h"

@interface BDJSignInViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginFrameLeadingLayoutConstraint;
@end

@implementation BDJSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)exitAciton:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeSignStateAction:(UIButton *)button {
    if (self.loginFrameLeadingLayoutConstraint.constant == 0) {
        self.loginFrameLeadingLayoutConstraint.constant = -self.view.width;
        button.selected = !button.selected;
    }else{
        self.loginFrameLeadingLayoutConstraint.constant = 0;
        button.selected = !button.selected;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
