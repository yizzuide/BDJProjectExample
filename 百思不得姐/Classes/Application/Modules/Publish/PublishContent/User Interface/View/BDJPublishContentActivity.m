//
//  BDJPublishContentActivity.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/15.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPublishContentActivity.h"
#import "BDJPublishContentEventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<BDJPublishContentEventHandlerPort>)

@interface BDJPublishContentActivity ()

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

#pragma mark - 初始化
- (void)config {
    self.view.backgroundColor = UIColorFromRGB(R_Color_GlobalBkg);
    
    self.navigationItem.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self.eventHandler action:@selector(xfLego_onDismissItemTouch)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:nil action:nil];
    // 开始使用禁用状态
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)setUpViews {
    
}

- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, EventHandler, Command)
    
    // load or reset expressPack
    /*XF_Define_Weak
    [RACObserve(self.eventHandler, expressPack) subscribeNext:^(id x) {
        XF_Define_Strong
        // 如果有显示数据加载完成
        if (x) {
            [self.tableView reloadData];
        }
    }];*/
}


#pragma mark - Change UI Action


#pragma mark - UIControlDelegate


#pragma mark - Getter



@end
