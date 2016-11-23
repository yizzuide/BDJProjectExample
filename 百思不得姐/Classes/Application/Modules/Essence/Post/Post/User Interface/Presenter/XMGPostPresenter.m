//
//  XMGPostPresenter.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPostPresenter.h"
#import "XMGPostWireframePort.h"
#import "XMGPostUserInterfacePort.h"
#import "XMGPostInteractorPort.h"
#import "ReactiveCocoa.h"
#import "XMGPostCategory.h"


#define Interactor XFConvertInteractorToType(id<XMGPostInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<XMGPostUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<XMGPostWireFramePort>)

@interface XMGPostPresenter ()

@end

@implementation XMGPostPresenter

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


// 接受到MVx构架或XFLegoVIPER模块的通知
- (void)receiveOtherModuleEventName:(NSString *)eventName intentData:(id)intentData
{
    // 匹配对应通知
    /*XF_EventIs_(NF_User_XXX, {
        // TODO
    })*/
}

#pragma mark - DoAction
- (void)didHeaderRefreshAction
{
    // XF_ModuleName为当前模块名，XMG_Post_Str2Type宏可以通过模块名找到对应帖子分类类型
    [[Interactor fetchPostsForType:XMG_Post_Str2Type(XF_ModuleName)] subscribeNext:^(XFRenderData *renderData) {
        // 设置并关联到当前模块的显示数据包
        XF_SetExpressPack_Fast(renderData);
    }];
}

- (RACSignal *)didFooterRefreshAction
{
    return [[Interactor fetchNextPagePostsForType:XMG_Post_Str2Type(XF_ModuleName)] map:^id(XFRenderData *renderData) {
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

#pragma mark - ValidData


@end
