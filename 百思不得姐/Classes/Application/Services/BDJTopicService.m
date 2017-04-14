//
//  BDJTopicService.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/6.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJTopicService.h"
#import "BDJHttpRequest.h"
#import "BDJAPI.h"
#import "MJExtension.h"
#import "BDJTopicModel.h"

@implementation BDJTopicService

- (RACSignal *)pullTopics
{
    return [[BDJHttpRequest getWithURL:API_Main
                                params:@{
                                         @"a": @"square",
                                         @"c":@"topic",
                                         }]
            map:^id(RACTuple *tuple) {
//                NSDictionary *dict = tuple.first;
//                [dict writeToFile:@"/Users/yizzuide/Desktop/topics.plist" atomically:YES];
                return [BDJTopicModel mj_objectArrayWithKeyValuesArray:tuple.first[@"square_list"]];
            }];
}
@end
