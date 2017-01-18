//
//  BDJMeActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJMeActivity.h"
#import "BDJMeEventHandlerPort.h"
#import "UIBarButtonItem+BDJExtension.h"
#import "XFSettings.h"
#import <UIViewController+XFSettings.h>
#import "BDJCircleImageCell.h"
#import "BDJMeFooterView.h"
#import "BDJTopicFrame.h"

#define EventHandler  XFConvertPresenterToType(id<BDJMeEventHandlerPort>)

@interface BDJMeActivity () <XFSettingTableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) BDJMeFooterView *footerView;
@end

@implementation BDJMeActivity

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(R_Color_GlobalBkg);

    [self configNav];
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
}

#pragma mark - 初始化
- (void)configNav
{
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:R_Image_MineSetting imageSel:R_Image_MineSettingSel];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:R_Image_MineMoon imageSel:R_Image_MineMoonSel];
    self.navigationItem.rightBarButtonItems = @[
                                              settingItem,
                                              moonItem
                                               ];
}

- (void)setUpViews {
    // set cell attrs
    XFCellAttrsData *cellAttrsData = [[XFCellAttrsData alloc] init];
    // 设置图标大小
    cellAttrsData.contentIconSize = 35;
    // 设置内容间距
    cellAttrsData.contentEachOtherPadding = 15;
    // 标题文字大小（其它文字会按个大小自动调整）
    cellAttrsData.contentTextMaxSize = 15;
    // 表格风格
    cellAttrsData.tableViewStyle = UITableViewStyleGrouped;
    
    self.xf_cellAttrsData = cellAttrsData;
    // 设置数据源
    self.xf_dataSource = self;
    // 调用配置设置
    [self xf_setup];
    
    // 使用分组样式的cell会整体向下移动35高度，为了只有10间距，可设置10-35的顶部内边距
    self.xf_tableView.contentInset = UIEdgeInsetsMake(R_Size_PostCellMargin - 35, 0, 0, 0);
    // 使用分组间距保持10的高度
    self.xf_tableView.sectionHeaderHeight = 0;
    self.xf_tableView.sectionFooterHeight = R_Size_PostCellMargin;
    
}

- (void)bindViewData {
    
    [[EventHandler DidFooterViewInitAction] subscribeNext:^(NSArray<XFExpressPiece *> *expressPieces) {
        BDJMeFooterView *footerView = [[BDJMeFooterView alloc] init];
        footerView.height = ((expressPieces.count + SqaureMaxCols - 1)  / SqaureMaxCols) * ScreenSize.width / SqaureMaxCols;
        [footerView setExpressPeices:expressPieces];
        self.xf_tableView.tableFooterView = footerView;
        self.footerView = footerView;
    }];
}


#pragma mark - Data Source
- (NSArray *)settingItems
{
    return @[ // 对应UITableView的Section数组
             @{ // 每一个Section
                 XFSettingGroupItems : @[ // 对应UITableView的cell数组
                         @{
                             XFSettingItemTitle: @"登录/注册",
                             XFSettingItemIcon : R_Image_UserDefault,
                             XFSettingItemClass: [XFSettingArrowItem class],
                             XFSettingItemRelatedCellClass: [BDJCircleImageCell class],
                             XFSettingItemDestViewControllerClass:[NSObject class],
                             },
                         ],
                 },
             @{
                 XFSettingGroupItems:@[
                         @{
                             XFSettingItemTitle: @"离线下载",
                             XFSettingItemClass: [XFSettingArrowItem class],
                             XFSettingItemDestViewControllerClass:[NSObject class],
                             }
                         ]
                 }
             ];
}

#pragma mark - UIControlDelegate



#pragma mark - Getter



@end
