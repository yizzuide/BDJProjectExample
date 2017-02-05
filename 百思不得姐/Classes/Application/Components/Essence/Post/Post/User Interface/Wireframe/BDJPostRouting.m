//
//  BDJPostRouting.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJPostRouting.h"

@implementation BDJPostRouting

// 组装一个共享的模块，使当前模块成为被共享状态，配合在视图层使用宏`XF_SubUInterface_`来动态添加子模块，不用再手动创建新的子路由类
XF_AutoAssemblyModuleForShareShell_Fast

// 跳转组件
- (void)transition2PostPictureBrowse
{
    XF_Present_URLComponent_Fast(@"bdj://indexTab/essence/post/postPictureBrowse")
}

- (void)transition2PostComment
{
    XF_PUSH_URLComponent_Fast(@"bdj://indexTab/essence/post/postComment")
}
@end
