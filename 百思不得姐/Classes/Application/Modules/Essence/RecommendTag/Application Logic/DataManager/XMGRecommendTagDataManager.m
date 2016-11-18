//
//  XMGRecommendTagDataManager.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "XMGRecommendTagDataManager.h"
#import "XMGRecommendService.h"

@interface XMGRecommendTagDataManager ()

@property (nonatomic, strong) XMGRecommendService *recomendService;
@end

@implementation XMGRecommendTagDataManager

- (RACSignal *)grabRecommendTag
{
    return [self.recomendService pullRecommendTag];
}

- (XMGRecommendService *)recomendService {
	if(_recomendService == nil) {
		_recomendService = [[XMGRecommendService alloc] init];
	}
	return _recomendService;
}

@end
