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
    [RACObserve(self.eventHandler,expressPack) subscribeNext:^(id renderList) {
        XF_Define_Strong
        if (renderList) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadData];
            });
        }
    }];
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"load more users");
        // 加载更多数据
        [[EventHandler actionDidFooterRefresh] subscribeNext:^(NSMutableArray * indexPaths) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                // 检测当前刷新状态
                [self checkUsersState];
            });
        }];
    }];
}

#pragma mark - UITableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 检测当前刷新状态
    [self checkUsersState];
    return self.eventHandler.expressPack.expressPieces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    XMGRCUserRenderItem *renderItem = self.eventHandler.expressPack.expressPieces[indexPath.row].renderItem;
    cell.renderItem = renderItem;
    return cell;
}

- (void)checkUsersState
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
    [self.mj_footer endRefreshing];
    [self.mj_footer resetNoMoreData];
    
}

@end
