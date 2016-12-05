//
//  BDJPostDataManager.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJPostDataManager.h"
#import "BDJPostService.h"
#import "BDJPostCategory.h"


@interface BDJPostDataManager ()

@property (nonatomic, strong) BDJPostService *postService;
@end

@implementation BDJPostDataManager

- (RACSignal *)grabPostsForType:(BDJPostCategoryType)postType
{
    BDJPostDataMediaType mediaType = [self postSeviceMediaTypeForPostType:postType];
    // 是否是新帖
    BOOL isNew = [BDJ_Post_type2Type(postType) containsString:@"New"];
    return [self.postService pullPostsForType:mediaType isNew:isNew];
}

- (RACSignal *)grabPostsForType:(BDJPostCategoryType)postType maxtime:(NSInteger)maxtime atPage:(NSInteger)page
{
    BDJPostDataMediaType mediaType = [self postSeviceMediaTypeForPostType:postType];
    // 是否是新帖
    BOOL isNew = [BDJ_Post_type2Type(postType) containsString:@"New"];
    return [self.postService pullPostsForType:mediaType maxtime:maxtime atPage:page isNew:isNew];
}

- (BDJPostDataMediaType)postSeviceMediaTypeForPostType:(BDJPostCategoryType)postType
{
    BDJPostDataMediaType mediaType;
    switch (postType) {
        case BDJPostCategoryTypeAll:
        case BDJPostCategoryTypeNewAll:
            mediaType = BDJPostDataMediaTypeAll;
            break;
        case BDJPostCategoryTypeVideo:
        case BDJPostCategoryTypeNewVideo:
            mediaType = BDJPostDataMediaTypeVideo;
            break;
        case BDJPostCategoryTypeVoice:
        case BDJPostCategoryTypeNewVoice:
            mediaType = BDJPostDataMediaTypeVoice;
            break;
        case BDJPostCategoryTypePicture:
        case BDJPostCategoryTypeNewPicture:
            mediaType = BDJPostDataMediaTypePicture;
            break;
        case BDJPostCategoryTypeWords:
        case BDJPostCategoryTypeNewWords:
            mediaType = BDJPostDataMediaTypeWords;
            break;
    }
    return mediaType;
}

- (BDJPostService *)postService {
	if(_postService == nil) {
		_postService = [[BDJPostService alloc] init];
	}
	return _postService;
}

@end
