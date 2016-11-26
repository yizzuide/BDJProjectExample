//
//  BDJPostActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostActivity.h"
#import "BDJPostEventHandlerPort.h"
#import "BDJPostCategory.h"
#import "BDJPostCell.h"
#import "BDJPostRenderItem.h"
#import <MJRefresh.h>
#import "BDJPostFrame.h"

#define EventHandler  XFConvertPresenterToType(id<BDJPostEventHandlerPort>)

@interface BDJPostActivity ()

@end

@implementation BDJPostActivity

static NSString * const Identifier = @"PostCell";

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
    // 调整显示内容内边距
    // 设置滚动内容内边距
    self.tableView.contentInset = UIEdgeInsetsMake(R_MaxY_PostHeaderTabs, 0, self.tabBarController.tabBar.height, 0);
    // 设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"BDJPostCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
}

- (void)setUpViews {
    XF_Define_Weak
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(self.tableView.mj_footer.isRefreshing) {
            [self.tableView.mj_footer endRefreshing];
        }
        XF_Define_Strong
        [EventHandler didHeaderRefreshAction];
    }];
    // 向下自动透明
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if(self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        XF_Define_Strong
        [[EventHandler didFooterRefreshAction] subscribeNext:^(NSArray<NSIndexPath *> *indexPaths) {
            [self.tableView.mj_footer endRefreshing];
            if (!indexPaths) {
                return;
            }
            // 局部插入行
           [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        }];
    }];
    self.tableView.mj_footer.hidden = YES;
}

- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, EventHandler, Command)
    
    [RACObserve(self.eventHandler, expressPack) subscribeNext:^(id x) {
        // 如果有显示数据加载完成
        if (x) {
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.hidden = NO;
        }
    }];
}


#pragma mark - UIControlDelegate

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventHandler.expressPack.expressPieces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJPostCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.expressPiece = self.eventHandler.expressPack.expressPieces[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDJPostFrame *postFrame = self.eventHandler.expressPack.expressPieces[indexPath.row].uiFrame;
    return postFrame.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Getter



@end
