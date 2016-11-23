//
//  XMGPostActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPostActivity.h"
#import "XMGPostEventHandlerPort.h"
#import "XMGPostCategory.h"
#import "XMGPostCell.h"
#import "XMGPostRenderItem.h"

#define EventHandler  XFConvertPresenterToType(id<XMGPostEventHandlerPort>)

@interface XMGPostActivity ()

@end

@implementation XMGPostActivity

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
    self.tableView.rowHeight = 145;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"XMGPostCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
}

- (void)setUpViews {
    
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
        }
    }];
}


#pragma mark - UIControlDelegate

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventHandler.expressPack.expressPieces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGPostCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    XMGPostRenderItem *item = self.eventHandler.expressPack.expressPieces[indexPath.row].renderItem;
    cell.renderItem = item;    
    return cell;
}



#pragma mark - Getter



@end
