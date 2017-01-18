//
//  BDJFriendsRecommentInteractor.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/12.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJFriendsRecommentInteractor.h"
#import "BDJFriendsRecommentDataManagerPort.h"
#import "BDJRecommendCategoryModel.h"
#import "BDJFriendsRecommendProvider.h"
#import "BDJRecommandUserModel.h"
#import "BDJRecommandUserGroupModel.h"
#import "BDJRCUserRenderData.h"

#define DataManager XFConvertDataManagerToType(id<BDJFriendsRecommentDataManagerPort>)

@interface BDJFriendsRecommentInteractor ()

@property (nonatomic, strong) NSArray<BDJRecommendCategoryModel *> *categorys;
@end

@implementation BDJFriendsRecommentInteractor

#pragma mark - Request
- (RACSignal *)fetchRecommendCategory
{
    return [[DataManager grabRecommendCategory] map:^id(NSArray *categoryList) {
        self.categorys = categoryList;
        return [BDJFriendsRecommendProvider collectCategoryRenderListFormArray:categoryList];
    }];
}

- (RACSignal *)fetchRecommendUserForCategoryIndex:(NSInteger)index
{
     BDJRecommendCategoryModel *recommendCategoryModel = self.categorys[index];
    // 先在内存缓存查找
    if (recommendCategoryModel.users.count) {
        NSLog(@"数据从缓存中返回。。");
        BDJRCUserRenderData *renderData = [BDJFriendsRecommendProvider collectUserRenderDataFormArray:self.categorys[index].users];
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
    BDJRecommendCategoryModel *recommendCategoryModel = self.categorys[index];
    // 增加页数
    recommendCategoryModel.currentPage++;
    return [[self _loadUsersForCategory:recommendCategoryModel] doError:^(NSError *error) {
        // 错误时恢复页数
        recommendCategoryModel.currentPage--;
    }];
}

- (RACSignal *)_loadUsersForCategory:(BDJRecommendCategoryModel *)recommendCategoryModel
{
    NSInteger categoryID = recommendCategoryModel.ID;
    return [[DataManager grabRecommendUserForCategoryID:categoryID atPage:recommendCategoryModel.currentPage] map:^id(BDJRecommandUserGroupModel *userGroupModel) {
        // 跟踪当前分类页数信息
        recommendCategoryModel.total = userGroupModel.total;
        recommendCategoryModel.next_page = userGroupModel.next_page;
        recommendCategoryModel.total_page = userGroupModel.total_page;
        // 缓存推荐用户模块到数组
        [recommendCategoryModel.users addObjectsFromArray:userGroupModel.list];
        // 转换渲染数据
        BDJRCUserRenderData *renderData = [BDJFriendsRecommendProvider collectUserRenderDataFormArray:userGroupModel.list];
        // 标识是加载完了
        renderData.loadFinish = recommendCategoryModel.total == recommendCategoryModel.users.count;
        return renderData;
    }];
}


#pragma mark - BusinessReduce


#pragma mark - ConvertData


@end
