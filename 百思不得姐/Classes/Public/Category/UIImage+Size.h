//
//  UIImage+Size.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/26.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)
/**
 *  获得图处最上段
 *
 *  @param dest   裁剪大小
 *
 */
- (UIImage *)topPartImageForDestSize:(CGSize)dest;
/**
 *  图形图
 *
 */
- (UIImage *)cricle;
@end
