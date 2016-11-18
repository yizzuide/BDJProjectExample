//
//  XMGRecommendTagPresenter.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGRecommendTagPresenter.h"
#import "XMGRecommendTagWireframePort.h"
#import "XMGRecommendTagUserInterfacePort.h"
#import "XMGRecommendTagInteractorPort.h"
#import "ReactiveCocoa.h"


#define Interactor XFConvertInteractorToType(id<XMGRecommendTagInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<XMGRecommendTagUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<XMGRecommendTagWireFramePort>)

@interface XMGRecommendTagPresenter ()

@end

@implementation XMGRecommendTagPresenter

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
    [[Interactor fetchRecommendTag] subscribeNext:^(XFRenderData *renderData) {
        XF_SetExpressPack_Fast(renderData);
    }];
}

#pragma mark - DoAction



#pragma mark - ValidData


@end
