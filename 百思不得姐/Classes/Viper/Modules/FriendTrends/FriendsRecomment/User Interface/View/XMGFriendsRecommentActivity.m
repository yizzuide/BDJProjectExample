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
#import "XMGRCCategoryTableView.h"
#import "XMGRCUserTableView.h"

#define EventHandler  XFConvertPresenterToType(id<XMGFriendsRecommentEventHandlerPort>)

@interface XMGFriendsRecommentActivity ()

@property (weak, nonatomic) IBOutlet XMGRCCategoryTableView *categoryTableView;
@property (weak, nonatomic) IBOutlet XMGRCUserTableView *userTableView;

@end

@interface XMGFriendsRecommentActivity ()

@end

@implementation XMGFriendsRecommentActivity

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
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

#pragma mark - Render Event
// 准备加载数据的UI状态
- (void)prepareForLoadDataUIState
{
    [self.userTableView beginHeaderRefreshing];
}

@end
