//
//  BDJMetaPostCmtModel.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/11/30.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJMetaPostCmtModel.h"
#import <MJExtension.h>
#import "BDJPostCmtModel.h"

@implementation BDJMetaPostCmtModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"hot":[BDJPostCmtModel class],
             @"data":[BDJPostCmtModel class]
             };
}
@end
