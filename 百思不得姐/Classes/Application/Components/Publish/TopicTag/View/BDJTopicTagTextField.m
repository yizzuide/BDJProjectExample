//
//  BDJTopicTagTextField.m
//  百思不得姐
//
//  Created by Yizzuide on 2017/2/13.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "BDJTopicTagTextField.h"

@implementation BDJTopicTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    return self;
}

- (void)deleteBackward
{
    // 先实现自定义删除
    !self.deleteBlock ?: self.deleteBlock();
    // 再调用系统默认行为
    [super deleteBackward];
}

// 新系统中，这引方法不再调用
- (void)insertText:(NSString *)text
{
    [super insertText:text];

    NSLog(@"%d", [text isEqualToString:@"\n"]);
}
@end
