//
//  XFFriendTrendsPresenter.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFFriendTrendsPresenter.h"
#import "XFFriendTrendsWireframePort.h"
#import "XFFriendTrendsUserInterfacePort.h"
#import "XFFriendTrendsInteractorPort.h"
#import "ReactiveCocoa.h"


#define Interactor XFConvertInteractorToType(id<XFFriendTrendsInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<XFFriendTrendsUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<XFFriendTrendsWireFramePort>)

@interface XFFriendTrendsPresenter ()

@end

@implementation XFFriendTrendsPresenter

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
    /*XF_CEXE_Begin
    // 当命令触发时执行代码
    XF_CEXE_(self.command, {
        // TODO
    })*/
}

// 注册MVx通知
- (void)registerMVxNotifactions
{
    // 注册MVx构架通知
//    XF_RegisterMVxNotis_(@[NF_User_XXX])
}


// 接受到MVx构架或XFLegoVIPER模块的通知
- (void)receiveOtherModuleEventName:(NSString *)eventName intentData:(id)intentData
{
    // 匹配对应通知
    /*XF_EventIs_(NF_User_XXX, {
        // TODO
    })*/
}

#pragma mark - DoAction



#pragma mark - ValidData


@end
