//
//  BDJPostCmtCell.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/1.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostCmtCell.h"
#import "BDJPostCmtRenderItem.h"
#import <UIImageView+WebCache.h>

@interface BDJPostCmtCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *nikeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@end

@implementation BDJPostCmtCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 这里不用设置背景图了，在xib中添加一个背景图，使cell与cell之间看起来就有一条明显的分隔线
//    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setExpressPiece:(XFExpressPiece *)expressPiece
{
    _expressPiece = expressPiece;
    BDJPostCmtRenderItem *renderItem = expressPiece.renderItem;
    self.nikeNameLabel.text = renderItem.userName;
    [self.profileImageView sd_setImageWithURL:renderItem.profile placeholderImage:[UIImage imageNamed:R_Image_UserDefault]];
    NSString *sexImageName = renderItem.sexType == PostCmtRenderItemSexTypeMan ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexImageView.image = [UIImage imageNamed:sexImageName];
    self.likeCountLabel.text = renderItem.likeCount;
    self.commentContentLabel.attributedText = renderItem.autoDelectAtCmtContent;
    self.voiceButton.hidden = renderItem.commentContent;
    [self.voiceButton setTitle:renderItem.voiceSecond forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    XF_SetFrame_(self.contentView, {
        frame.origin.x = R_Size_PostCellMargin;
        frame.size.width -= R_Size_PostCellMargin * 2;
    })
}

@end
