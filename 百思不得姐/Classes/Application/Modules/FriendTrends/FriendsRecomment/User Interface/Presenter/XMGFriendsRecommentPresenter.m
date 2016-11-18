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
@property (nonatomic, strong) RACDisposable *signalDisposable;
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
    
    // 加载推荐分类
    [self requestFillCategoryList];
}


#pragma mark - DoAction
- (void)actionDidSelectCategoryAtIndex:(NSInteger)index
{
    // 记录当前选择分类
    self.selectedCategoryIndex = index;
    
    // 清空旧数据
    XF_ExpressPack_Clean();
    
    // 通知子视图显示下拉状态，准备加载数据
    [Interface prepareForLoadDataUIState];
}

- (RACSignal *)actionDidHeaderRefresh
{
    return [[Interactor fetchRecommendUserForCategoryIndex:self.selectedCategoryIndex] doNext:^(id renderData) {
        XF_SetExpressPack_Fast(renderData)
    }];
}

- (RACSignal *)actionDidFooterRefresh
{
    return [[Interactor fetchNextPageRecommendUserForCategoryIndex:self.selectedCategoryIndex] map:^id(XMGRCUserRenderData *renderData) {
        // 记录上一次的数据个数
        NSUInteger lastPicturesCount = self.expressPack.expressPieces.count;
        // 同步数据：修改加载完成状态
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
   self.signalDisposable = [[Interactor fetchRecommendCategory] subscribeNext:^(NSArray *renderList) {
        self.expressData = renderList;
    }];
}


#pragma mark - ValidData

- (void)viewWillResignFocus
{
    // 当前视图移除时取消请求的信号
    [self.signalDisposable dispose];
}

- (void)dealloc
{
    XF_Debug_M();
}
@end
