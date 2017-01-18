//
//  BDJIndexTabPresenter.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJIndexTabPresenter.h"
#import "BDJIndexTabWireframePort.h"
#import "BDJIndexTabUserInterfacePort.h"
#import "BDJIndexTabInteractorPort.h"
#import "ReactiveCocoa.h"


#define Interactor XFConvertInteractorToType(id<BDJIndexTabInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<BDJIndexTabUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<BDJIndexTabWireframePort>)

@interface BDJIndexTabPresenter () <UITabBarControllerDelegate>

@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation BDJIndexTabPresenter

#pragma mark - lifeCycle
- (void)viewDidLoad
{
    // 记录初始选择index
    UITabBarController *tabBar = self.userInterface;
    self.selectedIndex = tabBar.selectedIndex;
}

- (void)onNewIntent:(id)intentData
{
    LogWarning(@"%@",intentData);
}

- (void)componentWillBecomeFocus
{
    XF_Debug_M();
}

- (void)componentWillResignFocus
{
    XF_Debug_M();
}

#pragma mark - DoAction
- (void)didPublishButtonClickAction
{
    self.intentData = @"模块到控制器数据";
    [Routing transition2Publish];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // 如果不是选择同一个index
    if (self.selectedIndex != tabBarController.selectedIndex) {
        self.selectedIndex = tabBarController.selectedIndex;
        return;
    }
    // 发送重复选择通知
    XF_SendMVxNoti_(BDJTabBarSelectAgainNotification, nil)
    
}

#pragma mark - ValidData


@end
