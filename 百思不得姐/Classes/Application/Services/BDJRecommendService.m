//
//  BDJRecommendService.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJRecommendService.h"
#import "BDJHttpRequest.h"
#import "BDJAPI.h"
#import "MJExtension.h"
#import "BDJRecommendCategoryModel.h"
#import "BDJRecommandUserGroupModel.h"
#import "BDJRecommendTagModel.h"

@implementation BDJRecommendService

- (RACSignal *)pullRecommendCategory {
    return [[BDJHttpRequest getWithURL:API_Main
                                params:@{
                                             @"a":@"category",
                                             @"c":@"subscribe"
                                             }]
            map:^id(RACTuple *tuple) {
                return [BDJRecommendCategoryModel mj_objectArrayWithKeyValuesArray:tuple.first[@"list"]];
            }];
}

- (RACSignal *)pullRecommendUserForCategoryID:(NSInteger)CategoryID atPage:(NSInteger)pageNumber
{
    return [[BDJHttpRequest getWithURL:API_Main
                                params:@{
                                         @"a":@"list",
                                         @"c":@"subscribe",
                                         @"category_id":@(CategoryID),
                                         @"page":@(pageNumber)
                                         }]
            map:^id(RACTuple *tuple) {
                return [BDJRecommandUserGroupModel mj_objectWithKeyValues:tuple.first];
            }];
}

- (RACSignal *)pullRecommendTag
{
    return [[BDJHttpRequest getWithURL:API_Main
                                params:@{
                                         @"a":@"tag_recommend",
                                         @"action":@"sub",
                                         @"c":@"topic",
                                         }]
            map:^id(RACTuple *tuple) {
                return [BDJRecommendTagModel mj_objectArrayWithKeyValuesArray:tuple.first];
            }];
}

@end
