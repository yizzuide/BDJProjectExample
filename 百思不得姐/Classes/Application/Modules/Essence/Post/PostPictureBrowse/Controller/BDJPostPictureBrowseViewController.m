//
//  BDJPostPictureBrowseViewController.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostPictureBrowseViewController.h"
#import "BDJProgressView.h"
#import "SVProgressHUD.h"
#import "BDJPicturePostRenderItem.h"
#import <UIImageView+WebCache.h>
#import "XFExpressPack.h"

@interface BDJPostPictureBrowseViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet BDJProgressView *progressView;
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation BDJPostPictureBrowseViewController

// 把控制器导出为组件
XF_EXPORT_COMPONENT

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BDJPicturePostRenderItem *renderItem = self.componentData;
    if (renderItem.height > R_Height_PostPictureBrowseBreak) {
        [SVProgressHUD showErrorWithStatus:@"图片太大，移动端无法显示!"];
        return;
    }
    CGFloat h = ScreenSize.width * renderItem.height / renderItem.width;
    // 是否是大图
    if (renderItem.type == BDJPostRenderItemTypePictureLong) {
        self.imageView.frame = CGRectMake(0, 0, ScreenSize.width, h);
        self.scrollView.contentSize = CGSizeMake(0, h);
    } else {
        self.imageView.size = CGSizeMake(ScreenSize.width, h);
        // 如果图片高度超过屏高
        if (h > ScreenSize.height) {
            self.scrollView.contentSize = CGSizeMake(0, h);
        } else {
            self.imageView.centerY = ScreenSize.height * 0.5;
        }
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
