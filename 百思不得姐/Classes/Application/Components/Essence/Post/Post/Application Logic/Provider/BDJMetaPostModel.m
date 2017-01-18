//
//  BDJMetaPostModel.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJMetaPostModel.h"
#import <MJExtension.h>
#import "BDJPostModel.h"

@implementation BDJMetaPostModel

+ (void)load
{
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list":[BDJPostModel class]
                 };
    }];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"BDJMetaPostModel description:%@\n info: %@\nlist: %@\n",[super description], self.info, self.list];
}
@end
