//
//  XFIndexTabActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFIndexTabActivity.h"
#import "XFIndexTabEventHandlerPort.h"
#import "NSObject+XFLegoInvokeMethod.h"
#import "XFActivity.h"

#define EventHandler  XFConvertPresenterToType(id<XFIndexTabEventHandlerPort>)

@interface XFIndexTabActivity ()

@end

@implementation XFIndexTabActivity

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpChildActivitys];
}

#pragma mark - 初始化
- (void)setUpChildActivitys {
    // 添加子控制器
    XFActivity *essenceActivity = XF_SubUInterface_(@"Essence");
    essenceActivity.tabBarItem.title = @"精华";
    essenceActivity.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    essenceActivity.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    [self addChildViewController:essenceActivity];
    
    XFActivity *newActivity = XF_SubUInterface_(@"New");
    newActivity.tabBarItem.title = @"新帖";
    newActivity.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    newActivity.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    [self addChildViewController:newActivity];
    
    XFActivity *friendTrendsActivity = XF_SubUInterface_(@"FriendTrends");
    friendTrendsActivity.tabBarItem.title = @"关注";
    friendTrendsActivity.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    friendTrendsActivity.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    [self addChildViewController:friendTrendsActivity];
    
    XFActivity *MeActivity = XF_SubUInterface_(@"Me");
    MeActivity.tabBarItem.title = @"我";
    MeActivity.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    MeActivity.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    [self addChildViewController:MeActivity];
}

- (void)xfLego_ViewDidLoadForTabBarViewController
{
    [self bindViewData];
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
