//
//  BDJSettingViewController.m
//  百思不得姐
//
//  Created by Yizzuide on 2017/2/15.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "BDJSettingViewController.h"
#import "UIViewController+XFSettings.h"
#import "XFSettings.h"


@interface BDJSettingViewController () <XFSettingTableViewDataSource>

@end

@implementation BDJSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // set cell attrs
    XFCellAttrsData *cellAttrsData = [[XFCellAttrsData alloc] init];
    // 设置图标大小
//    cellAttrsData.contentIconSize = 20;
    // 设置内容间距
    cellAttrsData.contentEachOtherPadding = 15;
    // 标题文字大小（其它文字会按个大小自动调整）
    cellAttrsData.contentTextMaxSize = 13;
    // 表格风格
    cellAttrsData.tableViewStyle = UITableViewStyleGrouped;
    
    self.xf_cellAttrsData = cellAttrsData;
    // 设置数据源
    self.xf_dataSource = self;
    // 调用配置设置
    [self xf_setup];
}


- (NSArray *)settingItems
{
    return @[ // groupArr
             @{ // groupModel
                 XFSettingGroupItems : @[ // items
                         @{ // itemModel
                             XFSettingItemTitle: @"清理缓存",
                             // 这个字段用于判断是否有右边辅助功能的cell,不写则没有
                             XFSettingItemClass : [XFSettingInfoItem class],
                             XFSettingItemAttrRightInfo : @"当前：0MB",
                             // 自定义的cell
                             XFSettingItemRelatedCellClass:[XFSettingInfoCell class],
                             // 如果有目标控制器,保留向右箭头使用NSObject类型
                             XFSettingItemDestViewControllerClass : [NSObject class],
                             // 如果有可选操作
                             XFSettingOptionActionBlock : ^(XFSettingInfoDotCell *cell,XFSettingPhaseType phaseType,id intentData){
                                 // 如果被点击
                                 if (phaseType == XFSettingPhaseTypeCellInteracted) {
                                     
                                 }
                             }
                             },// end itemModel
                         ],// end items
                 }// end groupModel
             ];// endgroupArr
}

@end
