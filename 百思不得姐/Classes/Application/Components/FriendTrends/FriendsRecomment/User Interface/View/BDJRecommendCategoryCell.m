//
//  BDJCategoryCell.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJRecommendCategoryCell.h"
#import "BDJCategoryRenderItem.h"

@interface BDJRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *indicator;
@end

@implementation BDJRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColorFromRGB(R_Color_Section);
}

- (void)setRenderItem:(BDJCategoryRenderItem *)renderItem
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
    
    [self.textLabel sizeToFit];
    CGFloat textW = self.textLabel.width;
    self.textLabel.x = (self.contentView.width - textW) * 0.5;
    self.textLabel.y = (self.contentView.height - self.textLabel.height) * 0.5;
}

@end
