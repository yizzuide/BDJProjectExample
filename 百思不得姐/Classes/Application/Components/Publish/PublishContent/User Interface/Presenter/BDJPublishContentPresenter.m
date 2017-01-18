//
//  BDJPublishContentPresenter.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/15.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPublishContentPresenter.h"
#import "BDJPublishContentWireframePort.h"
#import "BDJPublishContentUserInterfacePort.h"
#import "BDJPublishContentInteractorPort.h"
#import "ReactiveCocoa.h"


#define Interactor XFConvertInteractorToType(id<BDJPublishContentInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<BDJPublishContentUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<BDJPublishContentWireFramePort>)

@interface BDJPublishContentPresenter ()

@end

@implementation BDJPublishContentPresenter

#pragma mark - lifeCycle
// 绑定视图层后调用
- (void)viewDidLoad
{
    // 解构URL参数
//    NSInteger userID = self.params[@"id"];
    LogWarning(@"%@",self.componentData);
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

// 接收到组件返回数据
- (void)onNewIntent:(id)intentData
{
    
}

- (void)componentWillBecomeFocus
{
    XF_Debug_M();
}
- (void)componentWillResignFocus
{
    XF_Debug_M();
    self.intentData = @"模块给控制器返回的数据";
}

// 注册MVx通知
- (void)registerMVxNotifactions
{
    // 注册MVx构架通知
//    XF_RegisterMVxNotis_(@[XFUserDidLoginNotifaction])
}


// 接受到MVx构架通知或XFLegoVIPER模块的事件
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    // 匹配对应通知
    /*XF_EventIs_(XFUserDidLoginNotifaction, {
        // TODO
    })*/
}

#pragma mark - DoAction



#pragma mark - ValidData


@end
