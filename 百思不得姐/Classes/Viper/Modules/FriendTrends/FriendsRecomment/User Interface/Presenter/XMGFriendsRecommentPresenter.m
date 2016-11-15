//
//  XMGFriendsRecommentPresenter.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/12.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGFriendsRecommentPresenter.h"
#import "XMGFriendsRecommentWireframePort.h"
#import "XMGFriendsRecommentUserInterfacePort.h"
#import "XMGFriendsRecommentInteractorPort.h"
#import "XMGRCUserRenderData.h"


#define Interactor XFConvertInteractorToType(id<XMGFriendsRecommentInteractorPort>)
#define Interface XFConvertUserInterfaceToType(id<XMGFriendsRecommentUserInterfacePort>)
#define Routing XFConvertRoutingToType(id<XMGFriendsRecommentWireFramePort>)

@interface XMGFriendsRecommentPresenter ()

@property (nonatomic, assign) NSInteger selectedCategoryIndex;
@end

@implementation XMGFriendsRecommentPresenter

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
    // 加载推荐分类
    [self requestFillCategoryList];
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
- (void)actionDidSelectCategoryAtIndex:(NSInteger)index
{
    // 记录当前选择分类
    self.selectedCategoryIndex = index;
    NSLog(@"selected index: %zd",index);
    [[Interactor fetchRecommendUserForCategoryIndex:index] subscribeNext:^(XFRenderData *renderData) {
        //        NSLog(@"%@",x);
        XF_SetExpressPack_Fast(renderData);
    }];
}

- (RACSignal *)actionDidFooterRefresh
{
    return [[Interactor fetchNextPageRecommendUserForCategoryIndex:self.selectedCategoryIndex] map:^id(XMGRCUserRenderData *renderData) {
        // 记录上一次的数据个数
        NSUInteger lastPicturesCount = self.expressPack.expressPieces.count;
        // 修改加载完成状态
        XMGRCUserRenderData *lastRenderData = self.expressPack.renderData;
        lastRenderData.loadFinish = renderData.loadFinish;
        // 添加新数据
        XF_AddExpressPack_Last(renderData)
        // 创建列表视图布局刷新的IndexPath
        NSMutableArray *indexPaths = [NSMutableArray array];
        NSUInteger count = renderData.list.count;
        for (int i = 0; i < count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastPicturesCount + i inSection:0];
            [indexPaths addObject:indexPath];
        }
        return indexPaths;
    }];
}

#pragma mark - Request
- (void)requestFillCategoryList
{
    [[Interactor fetchRecommendCategory] subscribeNext:^(NSArray *renderList) {
//        NSLog(@"%@",x);
        self.expressData = renderList;
    }];
}


#pragma mark - ValidData


@end
