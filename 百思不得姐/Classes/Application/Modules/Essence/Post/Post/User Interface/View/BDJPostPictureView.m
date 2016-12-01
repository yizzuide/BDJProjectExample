//
//  BDJPostPictureView.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostPictureView.h"
#import <UIImageView+WebCache.h>
#import "BDJPicturePostRenderItem.h"
#import "BDJProgressView.h"
#import "UIImage+Size.h"
#import "BDJPostFrame.h"
#import "UIView+XFLego.h"
#import "BDJPostEventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<BDJPostEventHandlerPort>)

@interface BDJPostPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gifFlagView;
@property (weak, nonatomic) IBOutlet UIButton *longFlagView;
@property (weak, nonatomic) IBOutlet BDJProgressView *progressView;

@end

@implementation BDJPostPictureView

+ (instancetype)postPictureView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // 发现图片的宽高显示不正角，去除自动拉伸
    self.autoresizingMask = UIViewAutoresizingNone;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPictureViewClick)];
    [self.pictureView addGestureRecognizer:tapGesture];
}

- (void)setExpressPiece:(XFExpressPiece *)expressPiece
{
    _expressPiece = expressPiece;
    
    BDJPicturePostRenderItem *renderItem = expressPiece.renderItem;
    if (renderItem.type == BDJPostRenderItemTypePictureGIF) {
        self.gifFlagView.hidden = NO;
    }else{
        self.gifFlagView.hidden = YES;
    }
    if (renderItem.type == BDJPostRenderItemTypePictureLong) {
        self.longFlagView.hidden = NO;
    } else {
        self.longFlagView.hidden = YES;
    }
    
    // 循环利用时恢复下载进度
    [self.progressView setProgress:renderItem.loadProgress animated:YES];
    // 使用sd_下载
    [self.pictureView sd_setImageWithURL:renderItem.url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        // 记录当前进度
        renderItem.loadProgress = progress;
        [self.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        // 如果长图，取最上部分
        if (renderItem.type == BDJPostRenderItemTypePictureLong) {
            BDJPostFrame *frame = expressPiece.uiFrame;
            self.pictureView.image = [image topPartImageForDestSize:CGSizeMake(frame.pictureF.size.width, R_Height_PostPictureBreak)];
        }
    }];
}

- (void)didPictureViewClick
{
    [EventHandler didPictureViewClickActionWithExpressPiece:self.expressPiece];
}

@end
