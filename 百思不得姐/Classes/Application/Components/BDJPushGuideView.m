//
//  BDJPushGuideView.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPushGuideView.h"

@implementation BDJPushGuideView

+ (instancetype)pushGuideView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}
- (IBAction)okAction:(id)sender {
    [self removeFromSuperview];
}

@end
