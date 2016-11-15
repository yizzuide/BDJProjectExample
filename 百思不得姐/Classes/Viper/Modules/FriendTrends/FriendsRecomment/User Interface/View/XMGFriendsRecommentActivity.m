//
//  XMGFriendsRecommentActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/12.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGFriendsRecommentActivity.h"
#import "XMGFriendsRecommentEventHandlerPort.h"
#import "SVProgressHUD.h"

#define EventHandler  XFConvertPresenterToType(id<XMGFriendsRecommentEventHandlerPort>)

@interface XMGFriendsRecommentActivity ()

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@interface XMGFriendsRecommentActivity ()

@end

@implementation XMGFriendsRecommentActivity

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self config];
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
}

#pragma mark - 初始化
- (void)config
{
    self.view.backgroundColor = UIColorFromRGB(R_Color_GlobalBkg);
    // 当控制器有多UITableView视图时，系统随机只调整一个，当有两个时就要手动设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
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
