//
//  BDJTagAccessoryView.m
//  百思不得姐
//
//  Created by Yizzuide on 2017/2/11.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "BDJTagAccessoryView.h"
#import "UIView+XFLego.h"
#import "BDJPublishContentEventHandlerPort.h"

#define EventHandler XFConvertPresenterToType(id<BDJPublishContentEventHandlerPort>)

@interface BDJTagAccessoryView ()

@property (weak, nonatomic) IBOutlet UIView *tagContainerView;
@property (nonatomic, weak) UIButton *addTagButton;
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation BDJTagAccessoryView

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIButton *addTagButton = [[UIButton alloc] init];
    [addTagButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addTagButton sizeToFit];
    addTagButton.height += R_Size_Tag_margin;
    [self.tagContainerView addSubview:addTagButton];
    self.addTagButton = addTagButton;
    
    // 当前视图还未显示，不能获得事件层, 请在-willMoveToWindow:方法中使用
//    NSLog(@"%@",self.eventHandler);
    
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [self.addTagButton addTarget:EventHandler action:@selector(actionDidAddTag) forControlEvents:UIControlEventTouchUpInside];
}


- (void)setTagNames:(NSArray *)tagNames
{
    // 清空旧数据
    [self.tagButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagButtons removeAllObjects];
    _tagNames = tagNames;
    
    // 添加标签
    NSUInteger count = self.tagNames.count;
    for (int i = 0; i < count; i++) {
        NSString *tagName = self.tagNames[i];
        UIButton *tagButton = [[UIButton alloc] init];
        tagButton.userInteractionEnabled = NO;
        [tagButton setTitle:tagName forState:UIControlStateNormal];
        [tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tagButton setBackgroundImage:[UIImage imageNamed:@"post-tag-bg"] forState:UIControlStateNormal];
        tagButton.titleLabel.font = [UIFont systemFontOfSize:R_Size_Font_Tag];
        [tagButton sizeToFit];
        tagButton.width += 3 * R_Size_Tag_margin;
        [self.tagContainerView addSubview:tagButton];
        [self.tagButtons addObject:tagButton];
    }
    
    // 更新当前视图高度
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算标签
    NSUInteger count = self.tagButtons.count;
    for (int i = 0; i < count; i++) {
        UIButton *tagButton = self.tagButtons[i];
        if (i == 0) { // 如果是第一个
            tagButton.x = 0;
            tagButton.y = 0;
        } else {
            // 上一个
            UIButton *lastTagButton = self.tagButtons[i - 1];
            CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + R_Size_Tag_margin;
            // 是否放在同一行
            if (self.tagContainerView.width - leftWidth >= tagButton.width) {
                tagButton.x = leftWidth;
                tagButton.y = lastTagButton.y;
            } else {
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + R_Size_Tag_margin;
            }
        }
    }
    
    
    // 添加按钮
    if (!self.tagButtons.count) {
        self.addTagButton.x = 0;
        self.addTagButton.y = 0;
        return;
    }
    UIButton *lastTagButton = self.tagButtons.lastObject;
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + R_Size_Tag_margin;
    // 容器视图是否能放下输入框
    if (self.tagContainerView.width - leftWidth >= self.addTagButton.width) {
        self.addTagButton.x = leftWidth;
        self.addTagButton.y = lastTagButton.y;
    } else {
        self.addTagButton.x = 0;
        self.addTagButton.y = CGRectGetMaxY(lastTagButton.frame) + R_Size_Tag_margin;
    }
    
    // 计算当前视图高度
    // 记录之前Y值
    CGFloat oldHeight = self.height;
    // 新的高度
    self.height = CGRectGetMaxY(self.addTagButton.frame) + R_Size_Tag_margin * 2 + 48;
    // 修改现在的Y值
    self.y -= self.height - oldHeight;
}

- (NSMutableArray *)tagButtons
{
	if (!_tagButtons){
        _tagButtons = @[].mutableCopy;
	}
	return _tagButtons;
}

@end
