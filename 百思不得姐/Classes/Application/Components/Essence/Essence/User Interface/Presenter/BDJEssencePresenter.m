//
//  BDJEssencePresenter.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJEssencePresenter.h"
#import "BDJEssenceWireframePort.h"
#import "BDJEssenceUserInterfacePort.h"
#import "BDJEssenceInteractorPort.h"
#import "ReactiveCocoa.h"


#define Interactor XFConvertInteractorToType(id<BDJEssenceInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<BDJEssenceUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<BDJEssenceWireFramePort>)

@interface BDJEssencePresenter ()

@end

@implementation BDJEssencePresenter

#pragma mark - lifeCycle

// 初始化命令
- (void)initCommand
{
    XF_CEXE_Begin
    // 当命令触发时执行代码
    XF_CEXE_(self.tagCommand, {
        [Routing transition2RecommendTag];
        
    })
}


#pragma mark - DoAction

- (void)didScrollIndicatorAction
{
    // 给帖子发模块事件，即使这些都是共享模块<只有路由的模块壳>，也要分别写明，而不能直接用"Post"
    XF_SendEventForComponents_(BDJPostPageChangeEvent, nil, @"AllPost",@"PicturePost",@"VideoPost",@"VoicePost",@"WordsPost")
}


#pragma mark - ValidData


@end
