//
//  BDJFriendTrendsPresenter.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJFriendTrendsPresenter.h"
#import "BDJFriendTrendsWireframePort.h"
#import "BDJFriendTrendsUserInterfacePort.h"
#import "BDJFriendTrendsInteractorPort.h"
#import "ReactiveCocoa.h"


#define Interactor XFConvertInteractorToType(id<BDJFriendTrendsInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<BDJFriendTrendsUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<BDJFriendTrendsWireFramePort>)

@interface BDJFriendTrendsPresenter ()

@end

@implementation BDJFriendTrendsPresenter

#pragma mark - lifeCycle
// 绑定视图层后调用
- (void)viewDidLoad
{
}

// 初始化视图数据
- (void)initRenderView
{
    // 填充绑定的ViewData
    //self.viewData = [Interactor fetchData];
}

// 初始化命令
- (void)initCommand
{
    XF_CEXE_Begin
    // 当命令触发时执行代码
    XF_CEXE_(self.friendsRecommentCommand, {
        [Routing transition2FriendsRecomment];
    })
    XF_CEXE_(self.signInCommand, {
        [Routing transition2SignIn];
    })
}

// 注册MVx通知
- (void)registerMVxNotifactions
{
    // 注册MVx构架通知
//    XF_RegisterMVxNotis_(@[NF_User_XXX])
}


// 接受到组件事件
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    // 匹配对应通知
    /*XF_EventIs_(NF_User_XXX, {
        // TODO
    })*/
}

#pragma mark - DoAction



#pragma mark - ValidData


@end
