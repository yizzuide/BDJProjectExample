//
//  BDJFriendsRecommentActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/12.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJFriendsRecommentActivity.h"
#import "BDJFriendsRecommentEventHandlerPort.h"
#import "SVProgressHUD.h"
#import "BDJRCCategoryTableView.h"
#import "BDJRCUserTableView.h"

#define EventHandler  XFConvertPresenterToType(id<BDJFriendsRecommentEventHandlerPort>)

@interface BDJFriendsRecommentActivity ()

@property (weak, nonatomic) IBOutlet BDJRCCategoryTableView *categoryTableView;
@property (weak, nonatomic) IBOutlet BDJRCUserTableView *userTableView;

@end

@interface BDJFriendsRecommentActivity ()

@end

@implementation BDJFriendsRecommentActivity

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self config];
}

#pragma mark - 初始化
- (void)config
{
    self.view.backgroundColor = UIColorFromRGB(R_Color_GlobalBkg);
    // 当控制器有多UITableView视图时，系统随机只调整一个，当有两个时就要手动设置
    self.automaticallyAdjustsScrollViewInsets = NO; // 取消自动调整
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

#pragma mark - Render Event
// 准备加载数据的UI状态
- (void)prepareForLoadDataUIState
{
    [self.userTableView beginHeaderRefreshing];
}

- (void)dealloc
{
    XF_Debug_M();
}

@end
