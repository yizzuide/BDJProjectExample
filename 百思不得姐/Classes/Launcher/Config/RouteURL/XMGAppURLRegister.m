//
//  XMGAppURLRegister.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGAppURLRegister.h"
#import "XFURLRoute.h"

@implementation XMGAppURLRegister

+ (void)urlRegister
{
    [XFURLRoute initURLGroup:@[
                                 @"xmg://indexTab", // Tab主UI框架页
                                 @"xmg://indexTab/publish", // 发布作品
                                 @"xmg://friendTrends/friendsRecomment", // 推荐朋友
                                 @"xmg://userCenter/signIn", // 登录
                                 @"xmg://essence/recommendTag", // 推荐标签
                                 @"xmg://essence/postPictrueBrowse" // 浏览大图
                                 ]];
}
@end
