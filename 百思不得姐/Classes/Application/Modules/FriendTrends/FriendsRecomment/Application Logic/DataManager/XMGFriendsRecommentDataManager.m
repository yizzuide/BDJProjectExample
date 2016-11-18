//
//  XMGFriendsRecommentDataManager.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/12.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "XMGFriendsRecommentDataManager.h"
#import "XMGRecommendService.h"

@interface XMGFriendsRecommentDataManager ()

@property (nonatomic, strong) XMGRecommendService *recommendService;
@end

@implementation XMGFriendsRecommentDataManager

- (RACSignal *)grabRecommendCategory
{
    return [self.recommendService pullRecommendCategory];
}

- (RACSignal *)grabRecommendUserForCategoryID:(NSInteger)CategoryID atPage:(NSInteger)pageNumber
{
    return [self.recommendService pullRecommendUserForCategoryID:CategoryID atPage:pageNumber];
}

- (XMGRecommendService *)recommendService {
	if(_recommendService == nil) {
		_recommendService = [[XMGRecommendService alloc] init];
	}
	return _recommendService;
}

@end
