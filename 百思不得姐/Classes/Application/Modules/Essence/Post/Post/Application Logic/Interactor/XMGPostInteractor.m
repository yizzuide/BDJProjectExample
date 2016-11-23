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


#pragma mark - BusinessReduce


#pragma mark - ConvertData




- (NSMutableDictionary<NSString *,__kindof XMGMetaPostModel *> *)postMap {
	if(_postMap == nil) {
        _postMap = @{}.mutableCopy;
	}
	return _postMap;
}

@end
