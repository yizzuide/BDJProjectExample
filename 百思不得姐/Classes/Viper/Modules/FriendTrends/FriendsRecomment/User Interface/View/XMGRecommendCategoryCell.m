//
//  XMGCategoryCell.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGRecommendCategoryCell.h"
#import "XMGCategoryRenderItem.h"

@interface XMGRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *indicator;
@end

@implementation XMGRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColorFromRGB(R_Color_Section);
}

- (void)setRenderItem:(XMGCategoryRenderItem *)renderItem
{
    _renderItem = renderItem;
    self.textLabel.text = renderItem.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.textLabel.textColor = selected ? UIColorFromRGB(R_Color_Front) : UIColorFromRGB(R_Color_SectionText);
    self.indicator.hidden = !selected;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.textLabel.height - self.textLabel.y * 2;
}

@end
