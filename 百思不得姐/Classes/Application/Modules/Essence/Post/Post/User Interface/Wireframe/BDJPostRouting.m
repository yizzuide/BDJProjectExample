//
//  BDJPostRouting.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJPostRouting.h"

@implementation BDJPostRouting

// 组装模块
XF_AutoAssemblyModule_Fast

// 跳转组件
- (void)transition2PostPictrueBrowse
{
    XF_Present_URLComponent_Fast(@"BDJ://essence/postPictrueBrowse");
}
@end
