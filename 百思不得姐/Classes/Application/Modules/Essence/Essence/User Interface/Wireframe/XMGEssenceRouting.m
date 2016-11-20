//
//  XMGEssenceRouting.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "XMGEssenceRouting.h"

@implementation XMGEssenceRouting

// 组装模块
XF_AutoAssemblyModuleWithNav_Fast

// 跳转模块
- (void)transition2RecommendTag
{
    XF_PUSH_URLComponent_Fast(@"xmg://essence/recommendTag")
}
@end
