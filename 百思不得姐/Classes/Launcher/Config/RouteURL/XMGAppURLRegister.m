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
                                 @"xmg://indexTab", // Tab主UI框架页
                                 @"xmg://friendTrends/friendsRecomment", // 推荐朋友
                                 @"xmg://userCenter/signIn", // 登录
                                 @"xmg://essence/recommendTag" //
                                 ]];
}
@end
