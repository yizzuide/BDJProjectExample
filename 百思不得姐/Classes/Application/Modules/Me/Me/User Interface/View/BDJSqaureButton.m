//
//  BDJSqaureButton.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/8.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJSqaureButton.h"
#import "BDJTopicFrame.h"
#import <UIButton+WebCache.h>
#import "UIView+XFLego.h"
#import "BDJMeEventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<BDJMeEventHandlerPort>)

@implementation BDJSqaureButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setBackgroundImage:[UIImage imageNamed:R_Image_PostCellBackground] forState:UIControlStateNormal];
//    self.adjustsImageWhenHighlighted = NO;
    [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setExpressPiece:(XFExpressPiece *)expressPiece
{
    _expressPiece = expressPiece;
    BDJTopicFrame *frame = expressPiece.uiFrame;
    BDJTopicRenderItem *renderItem = expressPiece.renderItem;
    self.frame = frame.topicF;
    [self setTitle:renderItem.topicName forState:UIControlStateNormal];
    [self sd_setImageWithURL:renderItem.topicIconURL forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

- (void)clickAction:(id)sender {
    [EventHandler didTopicSelectAction:self.expressPiece];
}

@end
