//
//  XMGPostPictrueBrowseViewController.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPostPictrueBrowseViewController.h"
#import "XMGProgressView.h"
#import "SVProgressHUD.h"
#import "XMGPictruePostRenderItem.h"
#import <UIImageView+WebCache.h>
#import "XFExpressPack.h"

@interface XMGPostPictrueBrowseViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet XMGProgressView *progressView;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation XMGPostPictrueBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XMGPictruePostRenderItem *renderItem = self.intentData;
    if (renderItem.height > 17000) {
        [SVProgressHUD showErrorWithStatus:@"图片太大，移动端无法显示!"];
        return;
    }
    CGFloat h = ScreenSize.width * renderItem.height / renderItem.width;
    // 是否是大图
    if (renderItem.type == XMGPostRenderItemTypePictrueLong) {
        self.imageView.frame = CGRectMake(0, 0, ScreenSize.width, h);
        self.scrollView.contentSize = CGSizeMake(0, h);
    } else {
        self.imageView.size = CGSizeMake(ScreenSize.width, h);
        self.imageView.centerY = ScreenSize.height * 0.5;
    }
    
    // 使用cell中下载的进度
    [self.progressView setProgress:renderItem.loadProgress animated:YES];
    // 使用sd_下载
    [self.imageView sd_setImageWithURL:renderItem.url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
}

- (IBAction)saveAction:(id)sender {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并没下载完毕!"];
        return;
    }
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}


- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImageView *)imageView {
	if(_imageView == nil) {
		UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAction:)]];
        [self.scrollView addSubview:imageView];
        self.imageView = imageView;
	}
	return _imageView;
}

@end
