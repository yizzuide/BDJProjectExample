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

@property (nonatomic, strong) RACDisposable *disposable;
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
    
    // 下拉加载（这里Block没有写请求代码的原因：在多个分类点击时，这个加载状态就不控制，导致这个Block有时不能执行）
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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
    if (self.mj_footer.isRefreshing) {
        [self.mj_footer endRefreshing];
    }
    [self.mj_footer resetNoMoreData];
    
}

#pragma mark - RenderAction
- (void)beginHeaderRefreshing
{
    /**
     *  重置上拉状态
     */
    [self checkFooterRefreshState];
    // 取消上一次请求信号
    [self.disposable dispose];
    // 清空旧列表显示
    [self reloadData];
    // 开始刷新
    [self.mj_header beginRefreshing];
    // 开始请求数据
    self.disposable = [[EventHandler actionDidHeaderRefresh] subscribeNext:^(id x) {
        [self reloadData];
        [self.mj_header endRefreshing];
    }];
}

@end
