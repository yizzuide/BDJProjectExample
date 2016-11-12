//
//  XMGAppURLRegister.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGAppURLRegister.h"
#import "XFURLManager.h"

@implementation XMGAppURLRegister

+ (void)urlRegister
{
    [XFURLManager initURLGroup:@[
                                 @"xmg://indexTab",
                                 @"xmg://friendTrends/friendsRecomment"
                                 ]];
}
@end
