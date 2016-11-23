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

@interface XMGPostCell ()

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
    self.backgroundView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame
{
    CGFloat margin = 10;
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= margin * 2;
    frame.size.height -= margin;
    [super setFrame:frame];
}

- (void)setRenderItem:(XMGPostRenderItem *)renderItem
{
    self.nikeNameLabel.text = renderItem.userName;
    [self.prefileImageView sd_setImageWithURL:renderItem.ProfileUrl placeholderImage:[UIImage imageNamed:R_Image_UserDefault]];
    self.weibo_VImageView.hidden = !renderItem.isSina_v;
    self.createTimeLabel.text = renderItem.createTime;
}

@end
