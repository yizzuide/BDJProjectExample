//
//  BDJPostCommentPresenter.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/29.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostCommentPresenter.h"
#import "BDJPostCommentWireframePort.h"
#import "BDJPostCommentUserInterfacePort.h"
#import "BDJPostCommentInteractorPort.h"
#import "ReactiveCocoa.h"
#import "BDJPostRenderItem.h"


#define Interactor XFConvertInteractorToType(id<BDJPostCommentInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<BDJPostCommentUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<BDJPostCommentWireFramePort>)

@interface BDJPostCommentPresenter ()

@end

@implementation BDJPostCommentPresenter

#pragma mark - lifeCycle

- (void)viewWillBecomeFocusWithIntentData:(id)intentData
{
    [Interface fillPostExpressPiece:intentData];
}

#pragma mark - DoAction



#pragma mark - ValidData


@end
