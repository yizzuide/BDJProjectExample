//
//  XFPHTextField.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/17.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPHTextField.h"

static NSString * const XFPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation XFPHTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self config];
}

- (void)config
{
    // 设置光标色
    self.tintColor = self.textColor;
    // 调用设置占位颜色
    [self resignFirstResponder];
}

// 输入框获得焦点时调用
- (BOOL)becomeFirstResponder
{
    [self setValue:self.placeHolderFocusColor forKeyPath:XFPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:self.placeHolderColor forKeyPath:XFPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}
@end
