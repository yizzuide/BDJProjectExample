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
                                 @"bdj://indexTab", // Tab主UI框架页
                                 @"bdj://indexTab/publish", // 发布作品
                                 @"bdj://indexTab/publish/publishContent",
                                 @"bdj://friendTrends/friendsRecomment", // 推荐朋友
                                 @"bdj://userCenter/signIn", // 登录
                                 @"bdj://essence/recommendTag", // 推荐标签
                                 @"bdj://essence/post/postPictureBrowse", // 浏览大图
                                 @"bdj://essence/post/postComment", // 帖子评论
                                 ]];
    // 注册http的处理组件
    [XFURLRoute setHTTPHandlerComponent:@"WebBrowser"];
}
@end
