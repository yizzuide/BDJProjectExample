//
//  XMGRCUserTableView.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/14.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGRCUserTableView.h"
#import "UIView+XFLego.h"
#import "XFExpressPack.h"
#import "XMGRCUserRenderItem.h"
#import "XMGRecommendUserCell.h"
#import <MJRefresh.h>
#import "XMGRCUserRenderData.h"
#import "XMGFriendsRecommentEventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<XMGFriendsRecommentEventHandlerPort>)

@interface XMGRCUserTableView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) RACDisposable *signalDisposable;
@property (nonatomic, assign, getter=isProgrammingRefresh) BOOL programmingRefresh;
@end

@implementation XMGRCUserTableView

static NSString * const Identifier = @"RCUserCell";

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.dataSource = self;
    self.delegate = self;
    self.rowHeight = 75;
    [self registerNib:[UINib nibWithNibName:@"XMGRecommendUserCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
    XF_Define_Weak
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 加载更多数据
        XF_Define_Strong
        [[EventHandler actionDidFooterRefresh] subscribeNext:^(NSMutableArray * indexPaths) {
            [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
            [self checkFooterRefreshState];
        }];
    }];
    
    // 下拉加载
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        XF_Define_Strong
        // 如果是程序刷新，直接返回
        if (self.isProgrammingRefresh) {
            self.programmingRefresh = !self.programmingRefresh;
            return;
        }
        [self _sendActionForHeaderRefresh];
    }];
}

#pragma mark - UITableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventHandler.expressPack.expressPieces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    XMGRCUserRenderItem *renderItem = self.eventHandler.expressPack.expressPieces[indexPath.row].renderItem;
    cell.renderItem = renderItem;
    return cell;
}

// 检测当前刷新状态
- (void)checkFooterRefreshState
{
    XMGRCUserRenderData *renderData = self.eventHandler.expressPack.renderData;
    if (!renderData) {
        return;
    }
    // 如果列表总数加载完成
    if (renderData.isLoadFinish) {
        [self.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    // 如果正在刷新
    if (self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
    // 重置没有更多内容
    if (self.mj_footer.state == MJRefreshStateNoMoreData) {
        [self.mj_footer resetNoMoreData];
    }
    
}

#pragma mark - RenderAction
- (void)beginHeaderRefreshing
{
    // 重置上拉状态，这里一定要先判断是否在上拉，否则下面加载完成后再次调用checkFooterRefreshState方法，会造成状态错乱问题
    if (self.mj_footer.isRefreshing) {
        [self checkFooterRefreshState];
    }
    
    // 清空旧列表数据，先显示空白
    [self reloadData];
    
    // 标识为程序刷新
    self.programmingRefresh = YES;
    // 开始刷新
    [self.mj_header beginRefreshing];
    [self _sendActionForHeaderRefresh];
}

// 开始请求数据
- (void)_sendActionForHeaderRefresh
{
    // 取消上一次请求信号
    [self.signalDisposable dispose];
    // 开始请求数据
    self.signalDisposable = [[EventHandler actionDidHeaderRefresh] subscribeNext:^(id x) {
        [self reloadData];
        // 加载数据后再新检测上拉状态
        [self checkFooterRefreshState];
        [self.mj_header endRefreshing];
    }];
}

- (void)dealloc
{
    XF_Debug_M();
}

@end
