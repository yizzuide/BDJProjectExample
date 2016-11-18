//
//  XMGRecommendTagInteractor.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGRecommendTagInteractor.h"
#import "XMGRecommendTagDataManagerPort.h"
#import "XMGRecommendTagModel.h"
#import "XMGRecommendTagProvider.h"

#define DataManager XFConvertDataManagerToType(id<XMGRecommendTagDataManagerPort>)

@interface XMGRecommendTagInteractor ()

@end

@implementation XMGRecommendTagInteractor

#pragma mark - Request
- (RACSignal *)fetchRecommendTag
{
    return [[DataManager grabRecommendTag] map:^id(NSArray<XMGRecommendTagModel *> *array) {
        return [XMGRecommendTagProvider collectRenderDataFromArray:array];
    }];
}


#pragma mark - BusinessReduce


#pragma mark - ConvertData


@end
