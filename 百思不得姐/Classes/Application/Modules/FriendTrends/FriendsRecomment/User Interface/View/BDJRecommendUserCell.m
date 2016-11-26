//
//  BDJRecommendUserCell.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/14.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJRecommendUserCell.h"
#import "UIImageView+WebCache.h"
#import "BDJRCUserRenderItem.h"


@interface BDJRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headPortraitImage;
@property (weak, nonatomic) IBOutlet UILabel *nikeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;

@end

@implementation BDJRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRenderItem:(BDJRCUserRenderItem *)renderItem
{
    _renderItem = renderItem;
    [self.headPortraitImage sd_setImageWithURL:renderItem.headPortraitURL placeholderImage:[UIImage imageNamed:R_Image_UserDefault]];
    self.nikeNameLabel.text = renderItem.nikeName;
    self.fansLabel.text = renderItem.fansCount;
    
}
@end
