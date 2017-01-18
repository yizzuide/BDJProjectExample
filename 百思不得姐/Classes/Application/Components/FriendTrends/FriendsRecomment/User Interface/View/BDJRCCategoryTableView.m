//
//  BDJRCCategoryTableView.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/14.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJRCCategoryTableView.h"
#import "UIView+XFLego.h"
#import "BDJRecommendCategoryCell.h"
#import "SVProgressHUD.h"
#import "BDJFriendsRecommentEventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<BDJFriendsRecommentEventHandlerPort>)

@interface BDJRCCategoryTableView () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation BDJRCCategoryTableView

static NSString * const Identifier = @"RCCategoryCell";

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.dataSource = self;
    self.delegate = self;
    [self registerNib:[UINib nibWithNibName:@"BDJRecommendCategoryCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
    [SVProgressHUD show];
    [RACObserve(self.eventHandler,expressData) subscribeNext:^(id renderList) {
        if (renderList) {
            [SVProgressHUD dismiss];
            [self reloadData];
            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
            [self selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
            // 通知事件层选择了第一个分类
            [EventHandler actionDidSelectCategoryAtIndex:0];
        }
    }];
}

#pragma mark - UITableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.eventHandler expressData] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BDJRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    BDJCategoryRenderItem *renderItem = self.eventHandler.expressData[indexPath.row];
    cell.renderItem = renderItem;
    return cell;
}

#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [EventHandler actionDidSelectCategoryAtIndex:indexPath.row];
}

- (void)xfLego_viewWillPopOrDismiss
{
    [SVProgressHUD popActivity];
}

- (void)dealloc
{
    XF_Debug_M();
}
@end
