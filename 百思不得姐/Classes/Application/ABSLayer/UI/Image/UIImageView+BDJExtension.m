//
//  UIImageView+BDJExtension.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/4.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "UIImageView+BDJExtension.h"
#import <UIImageView+WebCache.h>
//#import "UIImage+Size.h"
#import "HJCornerRadius.h"

@implementation UIImageView (BDJExtension)

- (void)setProfileWithURL:(NSURL *)url
{
    // 使用图片上下文裁剪
    /*UIImage *placeHolder = [UIImage imageNamed:R_Image_UserDefault].cricle;
    [self sd_setImageWithURL:url placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) { // 如果没有图
            self.image = placeHolder;
        }else{
            self.image = image.cricle;
        }
    }];*/
    
    // 使用高性能的图片圆角库设置圆角半径
    self.aliCornerRadius = self.width * 0.5;
    UIImage *placeHolder = [UIImage imageNamed:R_Image_UserDefault];
    [self sd_setImageWithURL:url placeholderImage:placeHolder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 如果没有头像
        if (!image) self.image = placeHolder;
    }];
}
@end
