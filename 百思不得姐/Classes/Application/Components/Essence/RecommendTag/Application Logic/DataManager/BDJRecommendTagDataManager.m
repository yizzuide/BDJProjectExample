//
//  BDJRecommendTagDataManager.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJRecommendTagDataManager.h"
#import "BDJRecommendService.h"

@interface BDJRecommendTagDataManager ()

@property (nonatomic, strong) BDJRecommendService *recomendService;
@end

@implementation BDJRecommendTagDataManager

- (RACSignal *)grabRecommendTag
{
    return [self.recomendService pullRecommendTag];
}

- (BDJRecommendService *)recomendService {
	if(_recomendService == nil) {
		_recomendService = [[BDJRecommendService alloc] init];
	}
	return _recomendService;
}

@end
