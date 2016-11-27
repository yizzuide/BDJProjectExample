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


#define Interactor XFConvertInteractorToType(id<BDJPostInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<BDJPostUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<BDJPostWireFramePort>)

@interface BDJPostPresenter ()

@end

@implementation BDJPostPresenter

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

// 注册MVx通知
- (void)registerMVxNotifactions
{
    // 注册MVx构架通知
//    XF_RegisterMVxNotis_(@[NF_User_XXX])
}


// 接受到组件事件
- (void)receiveComponentEventName:(NSString *)eventName intentData:(id)intentData
{
    // 匹配对应通知
    /*XF_EventIs_(NF_User_XXX, {
        // TODO
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
        // 记录上一次的数据个数
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
        return indexPaths;
    }];
}

- (void)didPictureViewClickAction:(BDJPostPictureView *)PictureView
{
    // 预设要传过去的参数对象
    self.intentData = PictureView.expressPiece.renderItem;
    [Routing transition2PostPictureBrowse];
}

#pragma mark - ValidData


@end
