//
//  BDJNewActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJNewActivity.h"
#import "BDJNewEventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<BDJNewEventHandlerPort>)

@interface BDJNewActivity ()

@end

@implementation BDJNewActivity

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(R_Color_GlobalBkg);
    
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
}

#pragma mark - 初始化
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
