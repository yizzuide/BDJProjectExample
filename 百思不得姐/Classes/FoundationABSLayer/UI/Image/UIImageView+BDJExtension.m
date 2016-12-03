//
//  UIImageView+BDJExtension.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/4.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "UIImageView+BDJExtension.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Size.h"

@implementation UIImageView (BDJExtension)

- (void)setProfileWithURL:(NSURL *)url
{
    UIImage *placeHolder = [UIImage imageNamed:R_Image_UserDefault].cricle;
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:R_Image_UserDefault].cricle completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) { // 如果没有图
            self.image = placeHolder;
        }else{
            self.image = image.cricle;
        }
    }];
}
@end
