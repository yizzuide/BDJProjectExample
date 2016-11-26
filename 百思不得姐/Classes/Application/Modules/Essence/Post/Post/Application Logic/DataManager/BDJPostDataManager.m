//
//  BDJPostDataManager.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJPostDataManager.h"
#import "BDJPostService.h"


@interface BDJPostDataManager ()

@property (nonatomic, strong) BDJPostService *postService;
@end

@implementation BDJPostDataManager

- (RACSignal *)grabPostsForType:(BDJPostCategoryType)postType
{
    return [self.postService pullPostsForType:[self postSeviceMediaTypeForPostType:postType]];
}

- (RACSignal *)grabPostsForType:(BDJPostCategoryType)postType maxtime:(NSInteger)maxtime atPage:(NSInteger)page
{
    return [self.postService pullPostsForType:[self postSeviceMediaTypeForPostType:postType] maxtime:maxtime atPage:page];
}

- (BDJPostDataMediaType)postSeviceMediaTypeForPostType:(BDJPostCategoryType)postType
{
    BDJPostDataMediaType mediaType;
    switch (postType) {
        case BDJPostCategoryTypeAll:
            mediaType = BDJPostDataMediaTypeAll;
            break;
        case BDJPostCategoryTypeVideo:
            mediaType = BDJPostDataMediaTypeVideo;
            break;
        case BDJPostCategoryTypeVoice:
            mediaType = BDJPostDataMediaTypeVoice;
            break;
        case BDJPostCategoryTypePictrue:
            mediaType = BDJPostDataMediaTypePictrue;
            break;
        case BDJPostCategoryTypeWords:
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
