//
//  BDJMePresenter.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJMePresenter.h"
#import "BDJMeWireframePort.h"
#import "BDJMeUserInterfacePort.h"
#import "BDJMeInteractorPort.h"
#import "ReactiveCocoa.h"
#import "BDJTopicExpressPack.h"
#import "BDJTopicRenderItem.h"


#define Interactor XFConvertInteractorToType(id<BDJMeInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<BDJMeUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<BDJMeWireFramePort>)

@interface BDJMePresenter ()

@end

@implementation BDJMePresenter

#pragma mark - lifeCycle


#pragma mark - DoAction
- (RACSignal *)DidFooterViewInitAction
{
    return [[Interactor fetchTopics] map:^id(XFRenderData  *renderData) {
        XF_SetExpressPack_(BDJTopicExpressPack, renderData)
        return self.expressPack.expressPieces;
    }];
}

- (void)didTopicSelectAction:(XFExpressPiece *)expressPiece
{
    BDJTopicRenderItem *renderItem = expressPiece.renderItem;
    if ([renderItem.openURL hasPrefix:@"http:"]) {
        self.intentData = renderItem.openURL;
        [Routing transition2Browser];
        return;
    }
    
    LogWarning(@"不支持的协议：%@",renderItem.openURL);
}


#pragma mark - ValidData


@end
