//
//  XMGFriendsRecommentInteractor.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/12.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGFriendsRecommentInteractor.h"
#import "XMGFriendsRecommentDataManagerPort.h"
#import "XMGRecommendCategoryModel.h"
#import "XMGFriendsRecommendProvider.h"
#import "XMGRecommandUserModel.h"
#import "XMGRecommandUserGroupModel.h"
#import "XMGRCUserRenderData.h"

#define DataManager XFConvertDataManagerToType(id<XMGFriendsRecommentDataManagerPort>)

@interface XMGFriendsRecommentInteractor ()

@property (nonatomic, strong) NSArray<XMGRecommendCategoryModel *> *categorys;
@end

@implementation XMGFriendsRecommentInteractor

#pragma mark - Request
- (RACSignal *)fetchRecommendCategory
{
    return [[DataManager grabRecommendCategory] map:^id(NSArray *categoryList) {
        self.categorys = categoryList;
        return [XMGFriendsRecommendProvider collectCategoryRenderListFormArray:categoryList];
    }];
}

- (RACSignal *)fetchRecommendUserForCategoryIndex:(NSInteger)index
{
     XMGRecommendCategoryModel *recommendCategoryModel = self.categorys[index];
    // 先在内存缓存查找
    if (recommendCategoryModel.users.count) {
        NSLog(@"数据从缓存中返回。。");
        XMGRCUserRenderData *renderData = [XMGFriendsRecommendProvider collectUserRenderDataFormArray:self.categorys[index].users];
        // 标识是加载完了
        renderData.loadFinish = recommendCategoryModel.total == recommendCategoryModel.users.count;
        return [RACSignal return:renderData];
    }
    
    // 初始化页数
    recommendCategoryModel.currentPage = 1;
    return [self _loadUsersForCategory:recommendCategoryModel];
}

- (RACSignal *)fetchNextPageRecommendUserForCategoryIndex:(NSInteger)index
{
    XMGRecommendCategoryModel *recommendCategoryModel = self.categorys[index];
    // 增加页数
    recommendCategoryModel.currentPage++;
    return [[self _loadUsersForCategory:recommendCategoryModel] doError:^(NSError *error) {
        // 错误时恢复页数
        recommendCategoryModel.currentPage--;
    }];
}

- (RACSignal *)_loadUsersForCategory:(XMGRecommendCategoryModel *)recommendCategoryModel
{
    NSInteger categoryID = recommendCategoryModel.ID;
    return [[DataManager grabRecommendUserForCategoryID:categoryID atPage:recommendCategoryModel.currentPage] map:^id(XMGRecommandUserGroupModel *userGroupModel) {
        // 跟踪当前分类页数信息
        recommendCategoryModel.total = userGroupModel.total;
        recommendCategoryModel.next_page = userGroupModel.next_page;
        recommendCategoryModel.total_page = userGroupModel.total_page;
        // 缓存推荐用户模块到数组
        [recommendCategoryModel.users addObjectsFromArray:userGroupModel.list];
        // 转换渲染数据
        XMGRCUserRenderData *renderData = [XMGFriendsRecommendProvider collectUserRenderDataFormArray:userGroupModel.list];
        // 标识是加载完了
        renderData.loadFinish = recommendCategoryModel.total == recommendCategoryModel.users.count;
        return renderData;
    }];
}


#pragma mark - BusinessReduce


#pragma mark - ConvertData


@end
