//
//  XMGFriendTrendsRouting.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "XMGFriendTrendsRouting.h"

@implementation XMGFriendTrendsRouting

// 组装模块
XF_AutoAssemblyModule_FastNav(@"XMG")

// 跳转模块
- (void)transition2FriendsRecomment
{
    XF_PUSH_URLComponent_Fast(@"xmg://friendTrends/friendsRecomment")
}

- (void)transition2SignIn
{
    XF_Present_URLComponent_Fast(@"xmg://userCenter/signIn")
}
@end
