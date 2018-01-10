//
//  BDJPublishContentActivity.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/15.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPublishContentActivity.h"
#import "BDJPublishContentEventHandlerPort.h"
#import "XFTextView.h"
#import "BDJTagAccessoryView.h"

#define EventHandler  XFConvertPresenterToType(id<BDJPublishContentEventHandlerPort>)

@interface BDJPublishContentActivity () <UITextViewDelegate>

@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, weak) BDJTagAccessoryView *tagAccessoryView;
@end

@implementation BDJPublishContentActivity

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 配置当前视图
    [self config];
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // IOS9以前的系统，当键盘一直显示时不会发通知，可以让它先下去
    [self.view endEditing:YES];
    [self.textView becomeFirstResponder];
}
#pragma mark - 初始化
- (void)config {
    self.view.backgroundColor = UIColorFromRGB(R_Color_GlobalBkg);
    
    self.navigationItem.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self.eventHandler action:@selector(dismissViewAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(publishAciton)];
    // 开始使用禁用状态
    self.navigationItem.rightBarButtonItem.enabled = NO;
    // iOS10以下系统要强制刷新一下，才能使显示状态正常
    [self.navigationController.navigationBar layoutIfNeeded];
}

/**
 *  注意：当控制器从XIB中加载时，它的初始大小和文件里大小相同，不利适配屏幕，需要在方法-viewDidLayoutSubviews中设置布局，而通过代码创建的，所以能获得准确的宽高
 */
- (void)setUpViews {
    XFTextView *textView = [[XFTextView alloc] initWithFrame:self.view.bounds];
    textView.placeholderText = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.placeholderColor = [UIColor grayColor];
    [self.view addSubview:textView];
    textView.delegate = self;
    self.textView = textView;
    
    
    // 添加标签辅助视图 (当前主视图<ViewController>是通过代码创建的，所以能获得准确的宽高，如果是从XIB，就在方法-viewDidLayoutSubviews中设置布局)
    BDJTagAccessoryView *tagAccessoryView = [BDJTagAccessoryView viewFromXIB];
    tagAccessoryView.width = self.view.width;
    tagAccessoryView.y = self.view.height - tagAccessoryView.height;
    [self.view addSubview:tagAccessoryView];
    self.tagAccessoryView = tagAccessoryView;
}


- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, EventHandler, Command)

    XF_Define_Weak
    [RACObserve(self.eventHandler, expressData) subscribeNext:^(id x) {
        XF_Define_Strong
        // 如果有显示数据加载完成
        if (x) {
            // 填充标签组
            self.tagAccessoryView.tagNames = x;
        }
    }];
}


#pragma mark - Change UI Action

- (void)publishAciton {
    XF_Debug_M();
}

- (void)needUpdateInputUInterfaceY:(CGFloat)y durationTime:(CGFloat)durationTime
{
    [UIView animateWithDuration:durationTime animations:^{
        self.tagAccessoryView.transform = CGAffineTransformMakeTranslation(0, y - ScreenSize.height);
    }];
}

#pragma mark - UIControlDelegate
// 文本改变时设置完成状态
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - Getter


@end
