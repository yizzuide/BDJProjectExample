//
//  XFTextView.h
//  百思不得姐
//
//  Created by Yizzuide on 2017/2/9.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFTextView : UITextView
// 占位文本
@property (nonatomic, copy) NSString *placeholderText;
// 占位文本颜色
@property (nonatomic, strong) UIColor *placeholderColor;
@end
