//
//  BDJPostVoiceView.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/28.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostVoiceView.h"
#import <UIImageView+WebCache.h>
#import "BDJAVPostRenderItem.h"

@interface BDJPostVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;

@end

@implementation BDJPostVoiceView

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 发现图片的宽高显示不正角，去除自动拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setExpressPiece:(XFExpressPiece *)expressPiece
{
    _expressPiece = expressPiece;
    BDJAVPostRenderItem *renderItem = expressPiece.renderItem;
    [self.pictureView sd_setImageWithURL:renderItem.url];
    self.playCountLabel.text = renderItem.playCount;
    self.playTimeLabel.text = renderItem.playTimeLen;
}

@end
