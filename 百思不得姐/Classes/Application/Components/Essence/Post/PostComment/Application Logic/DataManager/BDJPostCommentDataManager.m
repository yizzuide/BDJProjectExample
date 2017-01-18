//
//  BDJPostCommentDataManager.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/29.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJPostCommentDataManager.h"
#import "BDJPostService.h"


@interface BDJPostCommentDataManager ()
@property (nonatomic, strong) BDJPostService *postService;
@end

@implementation BDJPostCommentDataManager

- (RACSignal *)grabPostCommentsWithPostID:(NSString *)ID
{
    return [self.postService pullPostCommentsWithPostID:ID];
}

- (RACSignal *)grabPostCommentsWithWithPostID:(NSString *)ID lastCommentID:(NSString *)lastCmtID atPage:(NSInteger)page
{
    return [self.postService pullPostCommentsWithWithPostID:ID lastCommentID:lastCmtID atPage:page];
}

- (BDJPostService *)postService {
	if(_postService == nil) {
		_postService = [[BDJPostService alloc] init];
	}
	return _postService;
}

@end
