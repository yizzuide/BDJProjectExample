//
//  XMGPostDataManager.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "XMGPostDataManager.h"
#import "XMGPostService.h"


@interface XMGPostDataManager ()

@property (nonatomic, strong) XMGPostService *postService;
@end

@implementation XMGPostDataManager

- (RACSignal *)grabPostsForType:(XMGPostCategoryType)postType
{
    return [self.postService pullPostsForType:[self postSeviceMediaTypeForPostType:postType]];
}

- (RACSignal *)grabPostsForType:(XMGPostCategoryType)postType maxtime:(NSInteger)maxtime atPage:(NSInteger)page
{
    return [self.postService pullPostsForType:[self postSeviceMediaTypeForPostType:postType] maxtime:maxtime atPage:page];
}

- (XMGPostDataMediaType)postSeviceMediaTypeForPostType:(XMGPostCategoryType)postType
{
    XMGPostDataMediaType mediaType;
    switch (postType) {
        case XMGPostCategoryTypeAll:
            mediaType = XMGPostDataMediaTypeAll;
            break;
        case XMGPostCategoryTypeVideo:
            mediaType = XMGPostDataMediaTypeVideo;
            break;
        case XMGPostCategoryTypeVoice:
            mediaType = XMGPostDataMediaTypeVoice;
            break;
        case XMGPostCategoryTypePictrue:
            mediaType = XMGPostDataMediaTypePictrue;
            break;
        case XMGPostCategoryTypeWords:
            mediaType = XMGPostDataMediaTypeWords;
            break;
    }
    return mediaType;
}

- (XMGPostService *)postService {
	if(_postService == nil) {
		_postService = [[XMGPostService alloc] init];
	}
	return _postService;
}

@end
