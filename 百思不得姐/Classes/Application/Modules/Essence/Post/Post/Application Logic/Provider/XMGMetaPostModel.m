//
//  XMGMetaPostModel.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGMetaPostModel.h"
#import <MJExtension.h>
#import "XMGPostModel.h"

@implementation XMGMetaPostModel

+ (void)load
{
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"list":[XMGPostModel class]
                 };
    }];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"XMGMetaPostModel description:%@\n info: %@\nlist: %@\n",[super description], self.info, self.list];
}
@end
