//
//  XMGProgressView.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGProgressView.h"

@implementation XMGProgressView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.roundedCorners = 2;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSInteger precent = [NSString stringWithFormat:@"%.2f",progress].floatValue * 100;
    NSString *progressPrecent = [NSString stringWithFormat:@"%zd%@",precent,@"%"];
    self.progressLabel.text = progressPrecent;
    self.progressLabel.textColor = [UIColor whiteColor];
    
}

@end
