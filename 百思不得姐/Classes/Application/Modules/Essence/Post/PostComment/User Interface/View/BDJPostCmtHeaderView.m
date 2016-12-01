//
//  BDJPostCmtHeaderView.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/1.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostCmtHeaderView.h"

@interface BDJPostCmtHeaderView ()

@end

@implementation BDJPostCmtHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColorFromRGB(R_Color_GlobalBkg);
        self.textLabel.textColor = UIColorFromRGB(R_Color_PostCmtSectionHeaderTitle);
        // 使textLabel在Section垂直居中
        self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.x = R_Size_PostCellMargin;
}

@end
