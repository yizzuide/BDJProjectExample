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
#import "UIBarButtonItem+BDJExtension.h"
#import <MJRefresh.h>
#import "BDJPostCmtRenderData.h"
#import "BDJPostCmtRenderItem.h"
#import "BDJPostCmtHeaderView.h"
#import "XFExpressPiecePort.h"

#define EventHandler  XFConvertPresenterToType(id<BDJPostCommentEventHandlerPort>)
#define HotCount ((BDJPostCmtRenderData *)self.eventHandler.expressPack.renderData).hotCount

@interface BDJPostCommentActivity () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputBarBottomConstraint;

@property (nonatomic, strong) RACDisposable *disposable;
@end

@implementation BDJPostCommentActivity

static NSString *HeaderIdentifier = @"PostCmtHeaderIdentifier";
static NSString *CellIdentifiler = @"PostCmtCellIdentifiler";

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
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" imageSel:@"comment_nav_item_share_icon_click" target:nil action:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, R_Height_PostInputBar +R_Size_PostCellMargin, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册
    [self.tableView registerClass:[BDJPostCmtHeaderView class] forHeaderFooterViewReuseIdentifier:HeaderIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"BDJPostCmtCell" bundle:nil] forCellReuseIdentifier:CellIdentifiler];
    
    // IOS8自动计算高度
    self.tableView.estimatedRowHeight = 56; // 评估初始高度
    self.tableView.rowHeight = UITableViewAutomaticDimension; // 设置高度为自动检测
}

- (void)setUpViews {
    XF_Define_Weak
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        XF_Define_Strong
        [self resetSignal];
        self.disposable = [EventHandler didPostCommentHeaderRefresh];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        XF_Define_Strong
        [self resetSignal];
        self.disposable = [[EventHandler didPostCommentFooterRefresh] subscribeNext:^(NSArray<NSIndexPath *> *indexPaths) {
            if (indexPaths.count) {
                // 局部插入行
                // 多个操作用动画块
                [self.tableView beginUpdates];
                [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                // 由于使用AutoLayout和自动计算cell高度，在插入行时会有跳动的问题<自动计算高度>，使用手动还原位置，但列表最后一段加载还是会跳动
                /*
                 the solution was to do ONE of the following:
                    * implement  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
                    * disable auto layout
                    * set a more accurate estimatedRowHeight on my UITableView
                 */
                [self.tableView scrollToRowAtIndexPath:[self.tableView.indexPathsForVisibleRows lastObject] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                [self.tableView endUpdates];
            }
            [self updateFooterRefreshState];
        }];
    }];
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
}


- (void)bindViewData {
    // 侦听数据包
    XF_Define_Weak
    [RACObserve(self.eventHandler, expressPack) subscribeNext:^(id x) {
        XF_Define_Strong
        if (x) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            [self updateFooterRefreshState];
        }
    }];
}

- (void)resetSignal
{
    [self.disposable dispose];
}
// 更新Footer刷新状态
- (void)updateFooterRefreshState
{
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
    BDJPostCmtRenderData *renderData = ExpressPack.renderData;
    self.tableView.mj_footer.hidden = renderData.isLoadFinish;
}

#pragma mark - Change UI State
// 填充帖子表头
- (void)fillPostExpressPiece:(XFExpressPiece *)expressPiece
{
    UIView *headerView = [[UIView alloc] init];
    BDJPostFrame *cellFrame = expressPiece.uiFrame;
    BDJPostCell *postCell = [BDJPostCell postCell];
    postCell.height = cellFrame.cellHeight;
    [postCell setExpressPiece:expressPiece];
    [headerView addSubview:postCell];
    postCell.width = ScreenSize.width;
    headerView.height = cellFrame.cellHeight + R_Size_PostCellMargin;
    self.tableView.tableHeaderView = headerView;
    
}

- (void)needUpdateInputBarY:(CGFloat)y durationTime:(CGFloat)time
{
    self.inputBarBottomConstraint.constant = y;
    [UIView animateWithDuration:time animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark - UIControlDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    // 滚动里让显示的菜单消失
    UIMenuController *menuVC = [UIMenuController sharedMenuController];
    if (menuVC.isMenuVisible) {
        [menuVC setMenuVisible:NO animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 使当前选择的cell成为第一响应者
    UIView *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell becomeFirstResponder]; // 注意：在切换第一响应者时，上一个显示响应者的菜单会自动消失（就像键盘成为第一响应者后也会消失一样）
    // 快捷菜单
    UIMenuController *menuVC = [UIMenuController sharedMenuController];
    if (menuVC.isMenuVisible) { // 重复点击当前cell使之隐藏
        [menuVC setMenuVisible:NO animated:YES];
    }else{
        // 创建自定义菜单
        // 创建的Action内部会找到第一响应者的控制器的方法来执行（所以在Cell类里要注册响应者）
        UIMenuItem *commentMI = [[UIMenuItem alloc] initWithTitle:@"评论" action:@selector(commentAction:)];
        UIMenuItem *collectMI = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(collectAction:)];
        UIMenuItem *reportMI = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(reportAction:)];
        menuVC.menuItems = @[commentMI,collectMI,reportMI]; // 注意：由于这个菜单控制器是共享的，所以其它地方显示不同菜单就会重新设置
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height); // 显示在cell中心位置
        [menuVC setTargetRect:rect inView:cell];  // 设置显示区域
        [menuVC setMenuVisible:YES animated:YES];
    }
}

#pragma mark - Menu Action
- (void)commentAction:(UIMenuController *)menu
{
    XF_Debug_M();
}

- (void)collectAction:(UIMenuController *)menu
{
    XF_Debug_M();
    // 获得当前选择的IndexPath
    /*NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UITableViewCell<XFExpressPiecePort> *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [EventHandler didCollectActionWithExpressPiece:cell.expressPiece];*/
}
- (void)reportAction:(UIMenuController *)menu
{
    XF_Debug_M();
}

#pragma mark - UITableView Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 如果有热评
    if (HotCount) {
        return 2;
    }
    if (ExpressPack.expressPieces.count) {
        return 1;
    }
    return 0;
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return HotCount ? @"最热评论" : @"最新评论";
    }
    return @"最新评论";
}*/
// 自定义Header要实现计算高度的方法，不然不会调用viewForHeaderInSection：方法
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return R_Height_PostCommentTableViewSectionHeader;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BDJPostCmtHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if (section == 0) {
        headerView.textLabel.text = HotCount ?  @"最热评论" : @"最新评论";
        return headerView;
    }
    headerView.textLabel.text = @"最新评论";
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger newListCount = ExpressPack.expressPieces.count - HotCount;
    if (section == 0) {
        return HotCount ? HotCount : newListCount;
    }
    return newListCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell<XFExpressPiecePort> *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifiler];
    XFExpressPiece *expressPiece = [self expressPieceForPath:indexPath];
    [cell setExpressPiece:expressPiece];
    return cell;
}

- (XFExpressPiece *)expressPieceForPath:(NSIndexPath *)indexPath
{
    XFExpressPiece *newCmtExpressPiece = ExpressPack.expressPieces[indexPath.row + HotCount];
    if (indexPath.section == 0) {
        return HotCount ? ExpressPack.expressPieces[indexPath.row] : newCmtExpressPiece;
    }
    return newCmtExpressPiece;
}

#pragma mark - Getter


- (void)xfLego_viewWillPopOrDismiss
{
    return [self resetSignal];
}
- (void)dealloc
{
    XF_Debug_M();
}
@end
