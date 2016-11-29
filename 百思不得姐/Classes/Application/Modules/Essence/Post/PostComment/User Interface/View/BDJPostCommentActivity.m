//
//  BDJPostCommentActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/29.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostCommentActivity.h"
#import "BDJPostCommentEventHandlerPort.h"
#import "BDJPostCell.h"
#import "XFExpressPiece.h"
#import "BDJPostFrame.h"

#define EventHandler  XFConvertPresenterToType(id<BDJPostCommentEventHandlerPort>)

@interface BDJPostCommentActivity ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BDJPostCommentActivity

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
}
- (void)setUpViews {
    

}

// 填充帖子表头
- (void)fillPostExpressPiece:(XFExpressPiece *)expressPiece
{
    BDJPostFrame *cellFrame = expressPiece.uiFrame;
    BDJPostCell *postCell = [BDJPostCell postCell];
    postCell.height = cellFrame.cellHeight;
    [postCell setExpressPiece:expressPiece];
    self.tableView.tableHeaderView = postCell;
    
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
