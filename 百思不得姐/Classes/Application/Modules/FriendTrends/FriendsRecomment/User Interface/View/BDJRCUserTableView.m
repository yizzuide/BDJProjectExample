//
//  BDJRCUserTableView.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/14.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJRCUserTableView.h"
#import "UIView+XFLego.h"
#import "XFExpressPack.h"
#import "BDJRCUserRenderItem.h"
#import "BDJRecommendUserCell.h"
#import <MJRefresh.h>
#import "BDJRCUserRenderData.h"
#import "BDJFriendsRecommentEventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<BDJFriendsRecommentEventHandlerPort>)

@interface BDJRCUserTableView () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) RACDisposable *signalDisposable;
@property (nonatomic, assign, getter=isProgrammingRefresh) BOOL programmingRefresh;
@end

@implementation BDJRCUserTableView

static NSString * const Identifier = @"RCUserCell";

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.dataSource = self;
    self.delegate = self;
    self.rowHeight = 75;
    self.backgroundColor = [UIColor clearColor];
    [self registerNib:[UINib nibWithNibName:@"BDJRecommendUserCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
    XF_Define_Weak
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        XF_Define_Strong
        // 加载更多数据
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
    BDJRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    BDJRCUserRenderItem *renderItem = self.eventHandler.expressPack.expressPieces[indexPath.row].renderItem;
    cell.renderItem = renderItem;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 效果来源：http://blog.csdn.net/helloworld_junyang/article/details/51751960
    /*NSArray *array =  tableView.indexPathsForVisibleRows;
    NSIndexPath *firstIndexPath = array[0];
    NSLog(@"fdasf---%ld---%lu",(long)firstIndexPath.row,(unsigned long)array.count);
    //设置anchorPoint
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    //为了防止cell视图移动，重新把cell放回原来的位置
    cell.layer.position = CGPointMake(0, cell.layer.position.y);
    //设置cell 按照z轴旋转90度，注意是弧度
    if (firstIndexPath.row < indexPath.row) {
        cell.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1.0);
    }else{
        cell.layer.transform = CATransform3DMakeRotation(- M_PI_2, 0, 0, 1.0);
    }
    cell.alpha = 0.0;
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DIdentity;
        cell.alpha = 1.0;
    }];*/
    
    
    /*cell.alpha = 0.5;
    CGAffineTransform transformScale = CGAffineTransformMakeScale(0.3,0.8);
    CGAffineTransform transformTranslate = CGAffineTransformMakeTranslation(0.5, 0.6);
    cell.transform = CGAffineTransformConcat(transformScale, transformTranslate);
    [tableView bringSubviewToFront:cell];
    [UIView animateWithDuration:.4f
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         cell.alpha = 1;
                         //清空 transform
                         cell.transform = CGAffineTransformIdentity;
                         
                     } completion:nil];*/
    
    
    CATransform3D rotation;//3D旋转
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    //逆时针旋转
    rotation.m34 = 1.0/ -600;
//    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
//    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotation;
    [UIView beginAnimations:@"rotation" context:NULL];
    // 获得cell显示个数
    float renderCellCount = ([UIScreen mainScreen].bounds.size.height - R_Height_StautsWithNavBar) / self.rowHeight;
    // 设置有一个周期内递增显示动画
    [UIView setAnimationDuration:(indexPath.row % (int)ceilf(renderCellCount)) / renderCellCount];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
//    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
    
    /*// 从锚点位置出发，逆时针绕 Y 和 Z 坐标轴旋转90度
    CATransform3D transform3D = CATransform3DMakeRotation(M_PI, 0.0, 1.0, 1.0);
    // 定义 cell 的初始状态
    cell.alpha = 0.0;
    cell.layer.transform = transform3D;
    cell.layer.anchorPoint = CGPointMake(0.0, 0.5); // 设置锚点位置；默认为中心点(0.5, 0.5)
    // 定义 cell 的最终状态，执行动画效果
    // 方式一：普通操作设置动画
    [UIView beginAnimations:@"transform" context:NULL];
    [UIView setAnimationDuration:0.5];
    cell.alpha = 1.0;
    cell.layer.transform = CATransform3DIdentity;
    CGRect rect = cell.frame;
    rect.origin.x = 0.0;
    cell.frame = rect;
    [UIView commitAnimations];*/
}

// 检测当前刷新状态
- (void)checkFooterRefreshState
{
    BDJRCUserRenderData *renderData = self.eventHandler.expressPack.renderData;
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
        // 加载数据后再重新检测上拉状态
        [self checkFooterRefreshState];
        [self.mj_header endRefreshing];
    }];
}

- (void)dealloc
{
    XF_Debug_M();
}

@end
