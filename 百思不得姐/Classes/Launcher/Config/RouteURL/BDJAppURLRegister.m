//
//  BDJAppURLRegister.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJAppURLRegister.h"
#import "XFURLRoute.h"

@implementation BDJAppURLRegister

+ (void)urlRegister
{
    [XFURLRoute initURLGroup:@[
                                 @"BDJ://indexTab", // Tab主UI框架页
                                 @"BDJ://indexTab/publish", // 发布作品
                                 @"BDJ://friendTrends/friendsRecomment", // 推荐朋友
                                 @"BDJ://userCenter/signIn", // 登录
                                 @"BDJ://essence/recommendTag", // 推荐标签
                                 @"BDJ://essence/post/postPictureBrowse", // 浏览大图
                                 @"BDJ://essence/post/postComment", // 帖子评论
                                 @"BDJ://me/web"
                                 ]];
}
@end
