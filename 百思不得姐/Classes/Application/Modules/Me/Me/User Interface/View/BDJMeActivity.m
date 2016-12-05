//
//  BDJMeActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJMeActivity.h"
#import "BDJMeEventHandlerPort.h"
#import "UIBarButtonItem+BDJExtension.h"

#define EventHandler  XFConvertPresenterToType(id<BDJMeEventHandlerPort>)

@interface BDJMeActivity ()

@end

@implementation BDJMeActivity

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
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:R_Image_MineSetting imageSel:R_Image_MineSettingSel];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:R_Image_MineMoon imageSel:R_Image_MineMoonSel];
    self.navigationItem.rightBarButtonItems = @[
                                              settingItem,
                                              moonItem
                                               ];
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
