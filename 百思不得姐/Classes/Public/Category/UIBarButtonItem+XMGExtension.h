//
//  UIBarButtonItem+XMGExtension.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/11.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XMGExtension)

+ (instancetype)itemWithImage:(NSString *)image imageSel:(NSString *)imageSel target:(id)target action:(SEL)action;
+ (instancetype)itemWithImage:(NSString *)image imageSel:(NSString *)imageSel;
@end
