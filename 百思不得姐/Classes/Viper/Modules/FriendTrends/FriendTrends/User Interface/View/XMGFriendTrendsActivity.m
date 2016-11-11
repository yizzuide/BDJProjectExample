//
//  XMGFriendTrendsActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGFriendTrendsActivity.h"
#import "XMGFriendTrendsEventHandlerPort.h"
#import "UIBarButtonItem+XMGExtension.h"

#define EventHandler  XFConvertPresenterToType(id<XMGFriendTrendsEventHandlerPort>)

@interface XMGFriendTrendsActivity ()

@end

@implementation XMGFriendTrendsActivity

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(R_Color_GlobalBkg);
    
    [self configNav];
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
}

#pragma mark - 初始化
- (void)configNav
{
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" imageSel:@"friendsRecommentIcon-click"];
}
- (void)setUpViews {
    
}

- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, EventHandler, Command)
}


#pragma mark - UIControlDelegate




#pragma mark - Getter



@end
