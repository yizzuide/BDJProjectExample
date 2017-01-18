//
//  BDJRecommendTagInteractor.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJRecommendTagInteractor.h"
#import "BDJRecommendTagDataManagerPort.h"
#import "BDJRecommendTagModel.h"
#import "BDJRecommendTagProvider.h"

#define DataManager XFConvertDataManagerToType(id<BDJRecommendTagDataManagerPort>)

@interface BDJRecommendTagInteractor ()

@end

@implementation BDJRecommendTagInteractor

#pragma mark - Request
- (RACSignal *)fetchRecommendTag
{
    return [[DataManager grabRecommendTag] map:^id(NSArray<BDJRecommendTagModel *> *array) {
        return [BDJRecommendTagProvider collectRenderDataFromArray:array];
    }];
}


#pragma mark - BusinessReduce


#pragma mark - ConvertData


@end
