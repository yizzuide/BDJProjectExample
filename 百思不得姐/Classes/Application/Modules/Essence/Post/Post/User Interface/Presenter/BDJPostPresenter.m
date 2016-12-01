//
//  BDJPostPresenter.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostPresenter.h"
#import "BDJPostWireframePort.h"
#import "BDJPostUserInterfacePort.h"
#import "BDJPostInteractorPort.h"
#import "ReactiveCocoa.h"
#import "BDJPostCategory.h"
#import "BDJPostExpressPack.h"
#import "BDJPostPictureView.h"
#import "BDJPostRenderItem.h"


#define Interactor XFConvertInteractorToType(id<BDJPostInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<BDJPostUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<BDJPostWireFramePort>)

@interface BDJPostPresenter ()

@end

@implementation BDJPostPresenter

#pragma mark - lifeCycle

// 接受到组件事件
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    /*XF_EventIs_(ET_PostPostScrollIndicator, {
        
    })*/
}

#pragma mark - DoAction
- (void)didHeaderRefreshAction
{
    // XF_ModuleName为当前模块名，BDJ_Post_Str2Type宏可以通过模块名找到对应帖子分类类型
    [[Interactor fetchPostsForType:BDJ_Post_Str2Type(XF_ModuleName)] subscribeNext:^(XFRenderData *renderData) {
        // 设置并关联到当前模块的显示数据包
        XF_SetExpressPack_(BDJPostExpressPack, renderData);
    }];
}

- (RACSignal *)didFooterRefreshAction
{
    return [[Interactor fetchNextPagePostsForType:BDJ_Post_Str2Type(XF_ModuleName)] map:^id(XFRenderData *renderData) {
        /*// 记录上一次的数据个数
        NSUInteger lastPostsCount = self.expressPack.expressPieces.count;
        
        // 添加新数据
        XF_AddExpressPack_Last(renderData)
        
        // 创建列表视图布局刷新的IndexPath
        NSMutableArray *indexPaths = [NSMutableArray array];
        NSUInteger count = renderData.list.count;
        for (int i = 0; i < count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastPostsCount + i inSection:0];
            [indexPaths addObject:indexPath];
        }
        return indexPaths;*/
        return XF_CreateIndexPaths_Last(renderData);
    }];
}

- (void)didPictureViewClickActionWithExpressPiece:(XFExpressPiece *)expressPiece
{
    // 预设要传过去的参数对象
    self.intentData = expressPiece.renderItem;
    [Routing transition2PostPictureBrowse];
}

- (void)didPostCellSelectedActionAtIndex:(NSInteger)index
{
    // 拷贝一份行数据片段作为下一个组件接收的意图数据
    self.intentData = self.expressPack.expressPieces[index];
    // 去除最热评论显示
    BDJPostRenderItem *renderItem = [self.intentData renderItem];
    if (renderItem.hotCmtContent) {
        renderItem.hotCmtContent = nil;
        // 重新计算高度
        [self.expressPack reMeasureFrameForExpressPiece:self.intentData];
    }
    // 查找帖子ID
    NSString *PostID = [Interactor fetchPostIDForIndex:index type:BDJ_Post_Str2Type(XF_ModuleName)];
    // 切换到评论
    [Routing transition2PostComment];
    // 发送选择帖子ID事件
    XF_SendEventForModule_(@"PostComment", ET_PostSelected, PostID)
}

#pragma mark - ValidData


@end
