//
//  XMGPostRouting.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "XMGPostRouting.h"

@implementation XMGPostRouting

// 组装模块
XF_AutoAssemblyModule_Fast

// 跳转组件
- (void)transition2PostPictrueBrowse
{
    XF_Present_URLComponent_Fast(@"xmg://essence/postPictrueBrowse");
}
@end
