//
//  BDJRecommandUserGroupModel.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/15.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJRecommandUserGroupModel.h"
#import <MJExtension.h>
#import "BDJRecommandUserModel.h"

@implementation BDJRecommandUserGroupModel

+ (void)load
{
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list": [BDJRecommandUserModel class]
                 };
    }];
}
@end
