//
//  BDJPostService.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostService.h"
#import "BDJHttpRequest.h"
#import "BDJAPI.h"
#import "MJExtension.h"
#import "BDJMetaPostCmtModel.h"

@implementation BDJPostService

- (RACSignal *)pullPostsForType:(BDJPostDataMediaType)postSeviceMediaType
{
    return [[BDJHttpRequest getWithURL:API_Main
                                params:@{
                                         @"a":@"list",
                                         @"c":@"data",
                                         @"type":@(postSeviceMediaType)
                                         }]
            map:^id(RACTuple *tuple) {
                /*if (postSeviceMediaType == BDJPostDataMediaTypeWords) {
                    NSDictionary *dict = tuple.first;
                    [dict writeToFile:@"/Users/yizzuide/Desktop/comment.plist" atomically:YES];
                }*/
                return [BDJMetaPostModel mj_objectWithKeyValues:tuple.first];
            }];
}

- (RACSignal *)pullPostsForType:(BDJPostDataMediaType)postSeviceMediaType maxtime:(NSInteger)maxtime atPage:(NSInteger)page
{
    return [[BDJHttpRequest getWithURL:API_Main
                                params:@{
                                         @"a":@"list",
                                         @"c":@"data",
                                         @"type":@(postSeviceMediaType),
                                         @"maxtime":@(maxtime),
                                         @"page":@(page)
                                         }]
            map:^id(RACTuple *tuple) {
                return [BDJMetaPostModel mj_objectWithKeyValues:tuple.first];
            }];
}

- (RACSignal *)pullPostCommentsWithPostID:(NSString *)ID
{
    return [[BDJHttpRequest getWithURL:API_Main
                                params:@{
                                         @"a":@"dataList",
                                         @"c":@"comment",
                                         @"data_id":ID,
                                         @"hot":@"1",
                                         }]
            map:^id(RACTuple *tuple) {
                /*NSDictionary *dict = tuple.first;
                [dict writeToFile:@"/Users/yizzuide/Desktop/PostComment.plist" atomically:YES];*/
                return [BDJMetaPostCmtModel mj_objectWithKeyValues:tuple.first];
            }];
}
@end
