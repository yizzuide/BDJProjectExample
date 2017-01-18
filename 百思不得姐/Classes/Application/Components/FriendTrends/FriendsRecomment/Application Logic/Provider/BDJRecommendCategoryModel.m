//
//  BDJRecommendCategoryModel.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJRecommendCategoryModel.h"
#import "MJExtension.h"

@implementation BDJRecommendCategoryModel

+ (void)load
{
    [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id"
            };
    }];
}

- (NSMutableArray<BDJRecommandUserModel *> *)users {
    if(_users == nil) {
        _users = [[NSMutableArray<BDJRecommandUserModel *> alloc] init];
    }
    return _users;
}
@end
