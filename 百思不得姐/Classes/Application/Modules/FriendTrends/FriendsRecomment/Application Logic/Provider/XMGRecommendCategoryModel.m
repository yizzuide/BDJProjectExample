//
//  XMGRecommendCategoryModel.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGRecommendCategoryModel.h"
#import "MJExtension.h"

@implementation XMGRecommendCategoryModel

+ (void)load
{
    [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
            @"ID" : @"id"
            };
    }];
}

- (NSMutableArray<XMGRecommandUserModel *> *)users {
    if(_users == nil) {
        _users = [[NSMutableArray<XMGRecommandUserModel *> alloc] init];
    }
    return _users;
}
@end
