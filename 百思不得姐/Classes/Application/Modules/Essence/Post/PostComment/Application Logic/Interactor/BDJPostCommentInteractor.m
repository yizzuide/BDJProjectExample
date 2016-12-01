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


#pragma mark - BusinessReduce


#pragma mark - ConvertData

- (void)dealloc
{
    XF_Debug_M();
}
@end
