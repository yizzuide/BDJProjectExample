//
//  XMGPostCell.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPostCell.h"
#import <UIImageView+WebCache.h>
#import "XMGPostRenderItem.h"
#import "UIView+XFLego.h"

@interface XMGPostCell ()

@property (nonatomic, weak) UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UIImageView *prefileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *weibo_VImageView;
@property (weak, nonatomic) IBOutlet UILabel *nikeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@end

@implementation XMGPostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 卡片方式一的样式设置
//    self.backgroundView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:R_Image_PostCellBackground]];
    
    // 卡片方式二的样式设置
    self.backgroundColor = [UIColor clearColor];
    UIImageView *cardImageView = [[UIImageView alloc] init];
    cardImageView.image = [UIImage imageNamed:R_Image_PostCellBackground];
    [self.contentView insertSubview:cardImageView atIndex:0];
    self.cardImageView = cardImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 卡片方式一：重置Cell的Frame，UITableView加载更多使用局部动画加载会有问题
/*- (void)setFrame:(CGRect)frame
{
    CGFloat margin = 10;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width = screenSize.width - margin * 2;
    frame.size.height -= margin;
    [super setFrame:frame];
}*/

// 卡片方式二：缩小ContentView的大小
- (void)layoutSubviews
{
    [super layoutSubviews];
    XF_SetFrame_(self.contentView, {
        frame.origin.x = R_Size_PostCellMargin;
        frame.origin.y = R_Height_PostCellClip;
        frame.size.width -= R_Size_PostCellMargin * 2;
        frame.size.height -= R_Size_PostCellMargin;
    })
    self.cardImageView.frame = self.contentView.bounds;
}

- (void)setRenderItem:(XMGPostRenderItem *)renderItem
{
    self.nikeNameLabel.text = renderItem.userName;
    [self.prefileImageView sd_setImageWithURL:renderItem.ProfileUrl placeholderImage:[UIImage imageNamed:R_Image_UserDefault]];
    self.weibo_VImageView.hidden = !renderItem.isSina_v;
    self.createTimeLabel.text = renderItem.createTime;
    [self.loveButton setTitle:renderItem.love forState:UIControlStateNormal];
    [self.hateButton setTitle:renderItem.hate forState:UIControlStateNormal];
    [self.repostButton setTitle:renderItem.rePost forState:UIControlStateNormal];
    [self.commentButton setTitle:renderItem.comment forState:UIControlStateNormal];
}

@end
