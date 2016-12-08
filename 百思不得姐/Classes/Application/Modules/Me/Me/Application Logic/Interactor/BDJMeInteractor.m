//
//  BDJMeInteractor.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJMeInteractor.h"
#import "BDJMeDataManagerPort.h"
#import "BDJTopicModel.h"
#import "BDJTopicProvider.h"

#define DataManager XFConvertDataManagerToType(id<BDJMeDataManagerPort>)

@interface BDJMeInteractor ()

@property (nonatomic, strong) NSArray<BDJTopicModel *> *topics;
@end

@implementation BDJMeInteractor

#pragma mark - Request
- (RACSignal *)fetchTopics
{
    return [[DataManager grabTopics] map:^id(NSArray<BDJTopicModel *> *topics) {
        self.topics = topics;
        return [BDJTopicProvider collectRenderDataFromArray:topics];
    }];
}


#pragma mark - BusinessReduce


#pragma mark - ConvertData


@end
