//
//  XMGPostService.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPostService.h"
#import "XMGHttpRequest.h"
#import "XMGAPI.h"
#import "MJExtension.h"

@implementation XMGPostService

- (RACSignal *)pullPostsForType:(XMGPostDataMediaType)postSeviceMediaType
{
    return [[XMGHttpRequest getWithURL:API_Main
                                params:@{
                                         @"a":@"list",
                                         @"c":@"data",
                                         @"type":@(postSeviceMediaType)
                                         }]
            map:^id(RACTuple *tuple) {
                return [XMGMetaPostModel mj_objectWithKeyValues:tuple.first];
            }];
}

- (RACSignal *)pullPostsForType:(XMGPostDataMediaType)postSeviceMediaType maxtime:(NSInteger)maxtime atPage:(NSInteger)page
{
    return [[XMGHttpRequest getWithURL:API_Main
                                params:@{
                                         @"a":@"list",
                                         @"c":@"data",
                                         @"type":@(postSeviceMediaType),
                                         @"maxtime":@(maxtime),
                                         @"page":@(page)
                                         }]
            map:^id(RACTuple *tuple) {
                return [XMGMetaPostModel mj_objectWithKeyValues:tuple.first];
            }];
}
@end
