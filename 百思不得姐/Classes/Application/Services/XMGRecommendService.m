//
//  XMGRecommendService.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGRecommendService.h"
#import "XMGHttpRequest.h"
#import "XMGAPI.h"
#import "MJExtension.h"
#import "XMGRecommendCategoryModel.h"
#import "XMGRecommandUserGroupModel.h"
#import "XMGRecommendTagModel.h"

@implementation XMGRecommendService

- (RACSignal *)pullRecommendCategory {
    return [[XMGHttpRequest getWithURL:API_Main
                                params:@{
                                             @"a":@"category",
                                             @"c":@"subscribe"
                                             }]
            map:^id(RACTuple *tuple) {
                return [XMGRecommendCategoryModel mj_objectArrayWithKeyValuesArray:tuple.first[@"list"]];
            }];
}

- (RACSignal *)pullRecommendUserForCategoryID:(NSInteger)CategoryID atPage:(NSInteger)pageNumber
{
    return [[XMGHttpRequest getWithURL:API_Main
                                params:@{
                                         @"a":@"list",
                                         @"c":@"subscribe",
                                         @"category_id":@(CategoryID),
                                         @"page":@(pageNumber)
                                         }]
            map:^id(RACTuple *tuple) {
                return [XMGRecommandUserGroupModel mj_objectWithKeyValues:tuple.first];
            }];
}

- (RACSignal *)pullRecommendTag
{
    return [[XMGHttpRequest getWithURL:API_Main
                                params:@{
                                         @"a":@"tag_recommend",
                                         @"action":@"sub",
                                         @"c":@"topic",
                                         }]
            map:^id(RACTuple *tuple) {
                return [XMGRecommendTagModel mj_objectArrayWithKeyValuesArray:tuple.first];
            }];
}

@end
