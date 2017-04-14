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

// 初始化视图数据
- (void)initRenderView
{
    // 设置默认标签
    self.expressData = @[@"吐糟",@"糗事"];
}

// 接收到组件返回数据
- (void)onNewIntent:(id)intentData
{
    LogInfo(@"完成后的标签：%@",intentData);
    self.expressData = intentData;
}

// 注册MVx通知
- (void)registerMVxNotifactions
{
    XF_RegisterKeyboardNotifaction
}


// 接受到MVx构架通知或XFLegoVIPER模块的事件
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    XF_HandleKeyboardNotifaction
}

#pragma mark - DoAction

- (void)actionDidAddTag
{
    
    UIViewController *view = self.userInterface;
    [view resignFirstResponder];
    // 设置组件意图传递数据
    self.intentData = self.expressData;
    [Routing transition2TopicTag];
}


#pragma mark - ValidData


@end
