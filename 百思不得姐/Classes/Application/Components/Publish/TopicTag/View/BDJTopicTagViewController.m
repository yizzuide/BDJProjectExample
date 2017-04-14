//
//  BDJTopicTagViewController.m
//  百思不得姐
//
//  Created by Yizzuide on 2017/2/13.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "BDJTopicTagViewController.h"
#import "SVProgressHUD.h"
#import "BDJTopicTagTextField.h"
#import "BDJTopicTagDataDriverProtocol.h"

#define DataDriver LEGORealPort(id<BDJTopicTagDataDriverProtocol>, self.dataDriver)

@interface BDJTopicTagViewController () <UITextFieldDelegate>

@property (nonatomic, weak) UIView *contentView;
@property (nonatomic, weak) BDJTopicTagTextField *textField;
@property (nonatomic, weak) UIButton *addButton;
@property (nonatomic, strong) NSMutableArray *tagButtons;
@end

@implementation BDJTopicTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加标签";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishAddTagAction)];
    
    // 添加子视图
    [self setupSubViews];
    // 这个绑定视图数据一定要放在添加子视图代码后面，它与ViewModel中的-initRenderView方法是一对CP
    [self bindViewData];
}

- (void)setupSubViews
{
    // 创建内容视图
    UIView *contentView = [[UIView alloc] init];
    contentView.x = R_Size_PostCellMargin;
    contentView.y = R_Size_PostCellMargin + R_Height_StautsWithNavBar;
    contentView.width = self.view.width - R_Size_PostCellMargin * 2;
    contentView.height = self.view.height;
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    // 输入框
    BDJTopicTagTextField *textField = [[BDJTopicTagTextField alloc] init];
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.width = self.view.width;
    textField.height = R_Height_Tag;
    textField.font = [UIFont systemFontOfSize:R_Size_Font_Tag];
    [contentView addSubview:textField];
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
//    [textField becomeFirstResponder];
    self.textField = textField;
    self.textField.delegate = self;
    XF_Define_Weak
    [self.textField setDeleteBlock:^{
        XF_Define_Strong
        self.textField.hasText ?: [self tagButtonClick:self.tagButtons.lastObject];
    }];
}

- (void)bindViewData
{
    XF_Define_Weak
    [RACObserve(DataDriver, expressData) subscribeNext:^(NSArray *tagNames) {
        XF_Define_Strong
        if (tagNames) {
            // 自动渲染Tag数据
            NSUInteger count = tagNames.count;
            for (int i = 0; i < count; i++) {
                // 模拟添加操作
                self.textField.text = tagNames[i];
                [self addButtonClick];
            }
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}


#pragma mark - 触发事件
- (void)finishAddTagAction
{
    NSArray *tagNames = [self.tagButtons valueForKeyPath:@"currentTitle"]; //[self.tagButtons valueForKeyPath:@"titleLabel.text"];
    [DataDriver backActionWithTagArray:tagNames];
}

- (void)textDidChange
{
    // 更新输入框的Frame，输入文本过长时自动移动到下一行
    [self updateTextFieldFrame];
    // 如果有文本
    if (self.textField.hasText) {
        // 显示添加按钮
        self.addButton.hidden = NO;
        self.addButton.y = CGRectGetMaxY(self.textField.frame) + R_Size_Tag_margin;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签: %@", self.textField.text] forState:UIControlStateNormal];
        
        // 判断输入逗号的情况
        NSInteger toIndex = self.textField.text.length - 1;
        NSString *comma = [self.textField.text substringFromIndex:self.textField.text.length - 1];
        if (([comma isEqualToString:@","] ||
             [comma isEqualToString:@"，"])) {
            // 去除逗号
            self.textField.text = [self.textField.text substringToIndex:toIndex];
            // 执行添加标签
            [self addButtonClick];
        }
    } else {
        self.addButton.hidden = YES;
    }
}

#pragma mark - 按钮事件
- (void)addButtonClick
{
    if (self.tagButtons.count == 5) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        return;
    }
    
    UIButton *tagButton = [[UIButton alloc] init];
    tagButton.titleLabel.font = [UIFont systemFontOfSize:R_Size_Font_Tag];
    [tagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"post-tag-bg"] forState:UIControlStateNormal];
    [tagButton sizeToFit];
    tagButton.width += 3 * R_Size_Tag_margin;
    [self.contentView addSubview:tagButton];
    [self.tagButtons addObject:tagButton];
    [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 清空
    self.textField.text = nil;
    self.addButton.hidden = YES;
    
    // 更新标签按钮的frame
    [self updateTagButtonFrame];
    [self updateTextFieldFrame];
}

- (void)tagButtonClick:(UIButton *)tagButton
{
    [tagButton removeFromSuperview];
    [self.tagButtons removeObject:tagButton];
    
    // 更新Frame
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagButtonFrame];
        [self updateTextFieldFrame];
    }];
}

#pragma mark - 计算Frame
- (void)updateTagButtonFrame
{
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
            if (self.contentView.width - leftWidth >= tagButton.width) {
                tagButton.x = leftWidth;
                tagButton.y = lastTagButton.y;
            } else {
                tagButton.x = 0;
                tagButton.y = CGRectGetMaxY(lastTagButton.frame) + R_Size_Tag_margin;
            }
        }
    }
}

- (void)updateTextFieldFrame
{
    UIButton *lastTagButton = self.tagButtons.lastObject;
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + R_Size_Tag_margin;
    // 容器视图是否能放下输入框
    if (self.contentView.width - leftWidth >= [self textFieldTextWidth]) {
        self.textField.x = leftWidth;
        self.textField.y = lastTagButton.y;
    } else {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + R_Size_Tag_margin;
    }
    
    // 更新添加按钮
    self.addButton.y = CGRectGetMaxY(self.textField.frame) + R_Size_Tag_margin;
}

/**
 * textField的文字宽度
 */
- (CGFloat)textFieldTextWidth
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    // 保证有一定的宽度，可以和标签放在同一行
    return MAX(100, textW);
}

#pragma mark - Delegate
// 实现换行代理方法，实现换行添加标签
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if (textField.hasText) {
        [self addButtonClick];
    }
    return YES;
}

#pragma mark - Getter
- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.width = self.contentView.width;
        addButton.height = R_Height_Tag;
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        addButton.titleLabel.font = [UIFont systemFontOfSize:R_Size_Font_Tag];
        addButton.contentEdgeInsets = UIEdgeInsetsMake(0, R_Size_Tag_margin, 0, R_Size_Tag_margin);
        // 让按钮内部的文字和图片都左对齐
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:addButton];
        _addButton = addButton;
    }
    return _addButton;
}

- (NSMutableArray *)tagButtons
{
	if (!_tagButtons){
        _tagButtons = @[].mutableCopy;
	}
	return _tagButtons;
}

- (void)dealloc
{
    XF_Debug_M()
}
@end
