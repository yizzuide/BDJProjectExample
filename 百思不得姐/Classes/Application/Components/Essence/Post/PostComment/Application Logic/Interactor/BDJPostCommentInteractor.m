//
//  BDJPostCommentInteractor.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/29.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostCommentInteractor.h"
#import "BDJPostCommentDataManagerPort.h"
#import "BDJMetaPostCmtModel.h"
#import "BDJPostCmtProvider.h"

#define DataManager XFConvertDataManagerToType(id<BDJPostCommentDataManagerPort>)

@interface BDJPostCommentInteractor ()

@property (nonatomic, strong) BDJMetaPostCmtModel *metaPostCmtModel;
@property (nonatomic, copy) NSString *postID;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation BDJPostCommentInteractor

#pragma mark - Request

- (void)cachePostID:(NSString *)ID
{
    self.postID = ID;
}

- (RACSignal *)fetchPostComments
{
    return [[DataManager grabPostCommentsWithPostID:self.postID] map:^id(BDJMetaPostCmtModel *metaPostCmtModel) {
        self.metaPostCmtModel = metaPostCmtModel;
        return [BDJPostCmtProvider collectRenderDataFromModel:metaPostCmtModel];
    }];
}

- (RACSignal *)fetchNextPagePostComments
{
    NSString *lastID = [self.metaPostCmtModel.data lastObject].ID;
    return [[DataManager grabPostCommentsWithWithPostID:self.postID lastCommentID:lastID atPage:self.currentPage + 1] map:^id(BDJMetaPostCmtModel * metaPostCmtModel) {
        self.currentPage++;
        // 添加到当前模型的最新评论数组
        [self.metaPostCmtModel.data addObjectsFromArray:metaPostCmtModel.data];
        return [BDJPostCmtProvider collectNextPageRenderDataFromModel:metaPostCmtModel hadLoadCount:self.metaPostCmtModel.data.count];
        
    }];
}

#pragma mark - BusinessReduce


#pragma mark - ConvertData

- (void)dealloc
{
    XF_Debug_M();
}
@end
