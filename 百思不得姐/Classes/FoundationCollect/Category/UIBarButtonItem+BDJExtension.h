//
//  UIBarButtonItem+BDJExtension.h
//
//
//  Created by 付星 on 2016/11/11.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BDJExtension)

+ (instancetype)itemWithImage:(NSString *)image imageSel:(NSString *)imageSel target:(id)target action:(SEL)action;
+ (instancetype)itemWithImage:(NSString *)image imageSel:(NSString *)imageSel;
@end
