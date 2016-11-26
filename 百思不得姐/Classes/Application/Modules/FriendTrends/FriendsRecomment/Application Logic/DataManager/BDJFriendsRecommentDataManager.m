//
//  BDJFriendsRecommentDataManager.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/12.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJFriendsRecommentDataManager.h"
#import "BDJRecommendService.h"

@interface BDJFriendsRecommentDataManager ()

@property (nonatomic, strong) BDJRecommendService *recommendService;
@end

@implementation BDJFriendsRecommentDataManager

- (RACSignal *)grabRecommendCategory
{
    return [self.recommendService pullRecommendCategory];
}

- (RACSignal *)grabRecommendUserForCategoryID:(NSInteger)CategoryID atPage:(NSInteger)pageNumber
{
    return [self.recommendService pullRecommendUserForCategoryID:CategoryID atPage:pageNumber];
}

- (BDJRecommendService *)recommendService {
	if(_recommendService == nil) {
		_recommendService = [[BDJRecommendService alloc] init];
	}
	return _recommendService;
}

@end
