//
//  XMGRCTagCellTableViewCell.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGRCTagCell.h"
#import <UIImageView+WebCache.h>
#import "XMGRCTagRenderItem.h"

@interface XMGRCTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *tagimageView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *subscribeLabel;

@end

@implementation XMGRCTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 强制设置cell的frame
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width = frame.size.width - frame.origin.x * 2;
    // 使它有下划线的效果
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)setRenderItem:(XMGRCTagRenderItem *)renderItem
{
    _renderItem = renderItem;
    [self.tagimageView sd_setImageWithURL:renderItem.imageURL placeholderImage:[UIImage imageNamed:R_Image_UserDefault]];
    self.tagLabel.text = renderItem.tagName;
    self.subscribeLabel.text = renderItem.subscribeAmount;
}

@end
