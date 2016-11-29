//
//  BDJPostCell.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostCell.h"
#import <UIImageView+WebCache.h>
#import "BDJPostRenderItem.h"
#import "UIView+XFLego.h"
#import "XFExpressPiece.h"
#import "BDJPostPictureView.h"
#import "BDJPostFrame.h"
#import "BDJPostVoiceView.h"
#import "BDJPostVideoView.h"
#import "XFExpressPiecePort.h"

@interface BDJPostCell ()

@property (nonatomic, weak) UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UIImageView *prefileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *weibo_VImageView;
@property (weak, nonatomic) IBOutlet UILabel *nikeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *loveButton;
@property (weak, nonatomic) IBOutlet UIButton *hateButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/**
 *  文本
 */
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
/**
 *  图片
 */
@property (nonatomic, weak) BDJPostPictureView *pictureView;
@property (nonatomic, weak) BDJPostVoiceView *voiceView;
@property (nonatomic, weak) BDJPostVideoView *videoView;

/**
 *  最热一条评论
 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation BDJPostCell

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

- (void)setExpressPiece:(XFExpressPiece *)expressPiece
{
    _expressPiece = expressPiece;
    BDJPostRenderItem *renderItem = expressPiece.renderItem;
    self.nikeNameLabel.text = renderItem.userName;
    [self.prefileImageView sd_setImageWithURL:renderItem.ProfileUrl placeholderImage:[UIImage imageNamed:R_Image_UserDefault]];
    self.weibo_VImageView.hidden = !renderItem.isSina_v;
    self.createTimeLabel.text = renderItem.createTime;
    [self.loveButton setTitle:renderItem.love forState:UIControlStateNormal];
    [self.hateButton setTitle:renderItem.hate forState:UIControlStateNormal];
    [self.repostButton setTitle:renderItem.rePostCount forState:UIControlStateNormal];
    [self.commentButton setTitle:renderItem.commentCount forState:UIControlStateNormal];
    self.bodyLabel.text = renderItem.text;
    // 如果有最热评论
    if (renderItem.topCmtContent) {
        self.topCmtView.hidden = NO;
        self.topCmtLabel.text = renderItem.topCmtContent;
    }else{
        self.topCmtView.hidden = YES;
    }
    
    // 根据帖子类型，填充视图
    if (renderItem.type == BDJPostRenderItemTypeWords) {
        [self hideAllMediaPictureExcludeView:nil];
        return;
    }
    
    if (renderItem.type == BDJPostRenderItemTypeVoice) {
        [self setupMediaView:self.voiceView];
    } else if (renderItem.type == BDJPostRenderItemTypeVideo) {
        [self setupMediaView:self.videoView];
    } else {
        [self setupMediaView:self.pictureView];
    }
}

- (void)setupMediaView:(UIView<XFExpressPiecePort> *)mediaView
{
    BDJPostFrame *postFrame = self.expressPiece.uiFrame;
    mediaView.frame = postFrame.pictureF;
    [mediaView setExpressPiece:self.expressPiece];
    [self hideAllMediaPictureExcludeView:mediaView];
}

// 隐藏所有类型图片，除了传入的视图
- (void)hideAllMediaPictureExcludeView:(UIView *)view
{
    self.pictureView.hidden = YES;
    self.voiceView.hidden = YES;
    self.videoView.hidden = YES;
    if (view) {
        view.hidden = NO;
    }
}

- (BDJPostPictureView *)pictureView {
	if(_pictureView == nil) {
		BDJPostPictureView *pictureView = [BDJPostPictureView postPictureView];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
	}
	return _pictureView;
}

- (BDJPostVoiceView *)voiceView {
	if(_voiceView == nil) {
		BDJPostVoiceView *voiceView = [BDJPostVoiceView postVoiceView];
        [self.contentView addSubview:voiceView];
        self.voiceView = voiceView;
	}
	return _voiceView;
}

- (BDJPostVideoView *)videoView {
	if(_videoView == nil) {
		BDJPostVideoView *videoView = [BDJPostVideoView postVideoView];
        [self.contentView addSubview:videoView];
        self.videoView = videoView;
	}
	return _videoView;
}

@end
