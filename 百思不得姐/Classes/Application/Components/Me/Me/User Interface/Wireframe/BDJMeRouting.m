//
//  BDJMeRouting.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJMeRouting.h"

@implementation BDJMeRouting

// 组装模块
XF_AutoAssemblyModule_Fast

// 跳转组件
- (void)transition2BrowserWithURL:(NSString *)url
{
    XF_PUSH_URLComponent_Fast(url)
}
@end
