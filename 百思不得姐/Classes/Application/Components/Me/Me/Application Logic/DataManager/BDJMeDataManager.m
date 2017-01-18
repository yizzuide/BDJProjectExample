//
//  BDJMeDataManager.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJMeDataManager.h"
#import "BDJTopicService.h"

@interface BDJMeDataManager ()

@property (nonatomic, strong) BDJTopicService *topicService;
@end

@implementation BDJMeDataManager

- (RACSignal *)grabTopics
{
    return [self.topicService pullTopics];
}

- (BDJTopicService *)topicService {
	if(_topicService == nil) {
		_topicService = [[BDJTopicService alloc] init];
	}
	return _topicService;
}

@end
