//
//  BDJRecommendTagPresenter.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJRecommendTagPresenter.h"
#import "BDJRecommendTagWireframePort.h"
#import "BDJRecommendTagUserInterfacePort.h"
#import "BDJRecommendTagInteractorPort.h"
#import "ReactiveCocoa.h"


#define Interactor XFConvertInteractorToType(id<BDJRecommendTagInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<BDJRecommendTagUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<BDJRecommendTagWireFramePort>)

@interface BDJRecommendTagPresenter ()

@end

@implementation BDJRecommendTagPresenter

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
