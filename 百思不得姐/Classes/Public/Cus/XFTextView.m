//
//  XFTextView.m
//  百思不得姐
//
//  Created by Yizzuide on 2017/2/9.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "XFTextView.h"

@interface XFTextView ()

@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation XFTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        // 默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 默认的占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        // 侦听文本改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_textViewEditing:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)_textViewEditing:(NSNotification *)noti
{
      // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
}


#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setPlaceholderText:(NSString *)placeholderText
{
    _placeholderText = [placeholderText copy];
    
    self.placeholderLabel.text = placeholderText;
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    // 更新文本改变
    [self _textViewEditing:nil];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    // 更新文本改变
    [self _textViewEditing:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    /*CGSize maxSize = CGSizeMake(self.width - 2 * self.placeholderLabel.x, MAXFLOAT);
    self.placeholderLabel.size = [self.placeholderText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;*/
    // 使用sizeToFit方式
    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

- (UILabel *)placeholderLabel
{
	if (!_placeholderLabel){
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.x = 4;
        placeholderLabel.y = 7;
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
	}
	return _placeholderLabel;
}

@end
