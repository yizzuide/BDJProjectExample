//
//  XMGPostInteractor.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPostInteractor.h"
#import "XMGPostDataManagerPort.h"
#import "XMGMetaPostModel.h"
#import "XMGPostProvider.h"

#define DataManager XFConvertDataManagerToType(id<XMGPostDataManagerPort>)

@interface XMGPostInteractor ()

@property (nonatomic, strong) NSMutableDictionary<NSString *,__kindof XMGMetaPostModel *> *postMap;
@end

@implementation XMGPostInteractor

#pragma mark - Request
- (RACSignal *)fetchPostsForType:(XMGPostCategoryType)postCategoryType
{
    return [[DataManager grabPostsForType:postCategoryType] map:^id(XMGMetaPostModel *postModel) {
        // 存储对应类型的帖子
        [self.postMap setObject:postModel forKey:XMG_Post_type2Type(postCategoryType)];
        // 返回显示数据
        return [XMGPostProvider collectPostRenderDataFromArray:postModel.list];
    }];
}

// 获得下一页
- (RACSignal *)fetchNextPagePostsForType:(XMGPostCategoryType)postCategoryType
{
    // 获得当前类型的预加载数据
    XMGMetaPostModel *preMetaPostModel = [self.postMap objectForKey:XMG_Post_type2Type(postCategoryType)];
    return [[DataManager grabPostsForType:postCategoryType maxtime:preMetaPostModel.info.maxtime atPage:preMetaPostModel.currentPage + 1] map:^id(XMGMetaPostModel *postModel) {
        // 返回成功后，增加页数
        preMetaPostModel.currentPage++;
        // 替换新的info
        preMetaPostModel.info = postModel.info;
        // 添加新列表数据
        [preMetaPostModel.list addObjectsFromArray:postModel.list];
        // 返回新加载的渲染数据
        return [XMGPostProvider collectPostRenderDataFromArray:postModel.list];
    }];
    
}


#pragma mark - BusinessReduce


#pragma mark - ConvertData




- (NSMutableDictionary<NSString *,__kindof XMGMetaPostModel *> *)postMap {
	if(_postMap == nil) {
        _postMap = @{}.mutableCopy;
	}
	return _postMap;
}

@end
