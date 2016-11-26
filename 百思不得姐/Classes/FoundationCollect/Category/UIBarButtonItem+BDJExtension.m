//
//  UIBarButtonItem+BDJExtension.m
//  
//
//  Created by 付星 on 2016/11/11.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "UIBarButtonItem+BDJExtension.h"

@implementation UIBarButtonItem (BDJExtension)

+ (instancetype)itemWithImage:(NSString *)image imageSel:(NSString *)imageSel target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:imageSel] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];}

+ (instancetype)itemWithImage:(NSString *)image imageSel:(NSString *)imageSel {
    return [self itemWithImage:image imageSel:imageSel target:nil action:nil];
}

@end
