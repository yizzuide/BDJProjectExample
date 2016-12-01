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

- (void)registerMVxNotifactions
{
    // 注册键盘通知
    XF_RegisterMVxNotis_(@[UIKeyboardWillChangeFrameNotification])
}

// 接收
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    XF_EventIs_(UIKeyboardWillChangeFrameNotification, {
        NSDictionary *dict = intentData;
        CGFloat y = ScreenSize.height - [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        [Interface needUpdateInputBarY:y durationTime:[dict[UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    })
    
    XF_EventIs_(ET_PostSelected, {
        LogWarning(@"%@",intentData);
        // 叫业务层缓存这个帖子ID
        [Interactor cachePostID:intentData];
    })
}

#pragma mark - DoAction
- (void)didPostCommentHeaderRefresh
{
    [[Interactor fetchPostComments] subscribeNext:^(XFRenderData *renderData) {
        XF_SetExpressPack_Fast(renderData)
    }];
}


#pragma mark - ValidData


@end
