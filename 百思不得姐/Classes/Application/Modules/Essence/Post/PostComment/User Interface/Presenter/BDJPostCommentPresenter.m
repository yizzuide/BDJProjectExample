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
#import "BDJPostCmtRenderData.h"


#define Interactor XFConvertInteractorToType(id<BDJPostCommentInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<BDJPostCommentUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<BDJPostCommentWireFramePort>)

#define HotCount ((BDJPostCmtRenderData *)self.expressPack.renderData).hotCount

@interface BDJPostCommentPresenter ()

@end

@implementation BDJPostCommentPresenter

#pragma mark - lifeCycle

- (void)initRenderView
{
    // 填充传递过来的组件对象
    [Interface fillPostExpressPiece:self.componentData];
}

- (void)registerMVxNotifactions
{
    // 注册键盘通知
    XF_RegisterMVxNotis_(@[UIKeyboardWillChangeFrameNotification])
}

- (void)componentWillBecomeFocus
{
    XF_Debug_M();
}

- (void)componentWillResignFocus
{
    XF_Debug_M();
    // 设置意图回传数据
    self.intentData = @"返回数据";
}

// 接收
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    XF_EventIs_(UIKeyboardWillChangeFrameNotification, {
        NSDictionary *dict = intentData;
        CGFloat y = ScreenSize.height - [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        [Interface needUpdateInputBarY:y durationTime:[dict[UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    })
    
    XF_EventIs_(BDJPostSelectedEvent, {
        // 叫业务层缓存这个帖子ID
        [Interactor cachePostID:intentData];
    })
}

#pragma mark - DoAction
- (RACDisposable *)didPostCommentHeaderRefresh
{
    return [[Interactor fetchPostComments] subscribeNext:^(BDJPostCmtRenderData *renderData) {
        // 手动赋值渲染对象的行为属性
        BDJPostCmtRenderData *preRenderData = self.expressPack.renderData;
        preRenderData.loadFinish = renderData.loadFinish;
        XF_SetExpressPack_Fast(renderData)
    }];
}

- (RACSignal *)didPostCommentFooterRefresh
{
    return [[Interactor fetchNextPagePostComments] map:^id(BDJPostCmtRenderData *renderData) {
        // 手动赋值渲染对象的行为属性
        BDJPostCmtRenderData *preRenderData = self.expressPack.renderData;
        preRenderData.loadFinish = renderData.loadFinish;
        
        /*// 记录上一次的数据个数
        NSUInteger lastPostsCount = self.expressPack.expressPieces.count - HotCount;
        
        // 添加新数据
        XF_AddExpressPack_Last(renderData)
        
        // 创建列表视图布局刷新的IndexPath
        NSMutableArray *indexPaths = [NSMutableArray array];
        NSUInteger count = renderData.list.count;
        for (int i = 0; i < count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastPostsCount + i inSection:HotCount ? 1 : 0];
            [indexPaths addObject:indexPath];
        }
        return indexPaths;*/
        // 上面注释代码是这一句宏的具体实现（返回UITableView局部刷新的IndexPath数组）
        return XF_CreateIndexPaths_Last(renderData, HotCount ? 1 : 0, HotCount);
    }];
}


#pragma mark - ValidData

- (void)dealloc
{
    XF_Debug_M();
}
@end
