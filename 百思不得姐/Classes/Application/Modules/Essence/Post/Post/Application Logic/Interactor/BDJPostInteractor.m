//
//  BDJPostInteractor.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostInteractor.h"
#import "BDJPostDataManagerPort.h"
#import "BDJMetaPostModel.h"
#import "BDJPostProvider.h"

#define DataManager XFConvertDataManagerToType(id<BDJPostDataManagerPort>)

@interface BDJPostInteractor ()

@property (nonatomic, strong) NSMutableDictionary<NSString *,__kindof BDJMetaPostModel *> *postMap;
@end

@implementation BDJPostInteractor

#pragma mark - Request
- (RACSignal *)fetchPostsForType:(BDJPostCategoryType)postCategoryType
{
    return [[DataManager grabPostsForType:postCategoryType] map:^id(BDJMetaPostModel *postModel) {
        // 存储对应类型的帖子
        [self.postMap setObject:postModel forKey:BDJ_Post_type2Type(postCategoryType)];
        // 返回显示数据
        return [BDJPostProvider collectPostRenderDataFromArray:postModel.list];
    }];
}

// 获得下一页
- (RACSignal *)fetchNextPagePostsForType:(BDJPostCategoryType)postCategoryType
{
    // 获得当前类型的预加载数据
    BDJMetaPostModel *preMetaPostModel = [self.postMap objectForKey:BDJ_Post_type2Type(postCategoryType)];
    return [[DataManager grabPostsForType:postCategoryType maxtime:preMetaPostModel.info.maxtime atPage:preMetaPostModel.currentPage + 1] map:^id(BDJMetaPostModel *postModel) {
        // 返回成功后，增加页数
        preMetaPostModel.currentPage++;
        // 替换新的info
        preMetaPostModel.info = postModel.info;
        // 添加新列表数据
        [preMetaPostModel.list addObjectsFromArray:postModel.list];
        // 返回新加载的渲染数据
        return [BDJPostProvider collectPostRenderDataFromArray:postModel.list];
    }];
    
}


#pragma mark - BusinessReduce


#pragma mark - ConvertData




- (NSMutableDictionary<NSString *,__kindof BDJMetaPostModel *> *)postMap {
	if(_postMap == nil) {
        _postMap = @{}.mutableCopy;
	}
	return _postMap;
}

@end
