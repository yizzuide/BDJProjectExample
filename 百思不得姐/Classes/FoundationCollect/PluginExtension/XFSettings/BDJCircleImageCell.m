//
//  BDJCircleImageCell.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/6.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJCircleImageCell.h"
#import "HJCornerRadius.h"

@implementation BDJCircleImageCell


- (void)setItem:(XFSettingItem *)item
{
    self.imageView.aliCornerRadius = self.cellAttrsData.contentIconSize * 0.5;
    [super setItem:item];
}

+ (NSString *)settingCellReuseIdentifierString
{
    return @"setting-circleImageCell";
}
@end
