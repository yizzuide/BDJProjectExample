//
//  BDJEssenceRouting.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJEssenceRouting.h"

@implementation BDJEssenceRouting

// 组装模块
XF_AutoAssemblyModuleWithNav_Fast

// 跳转组件
- (void)transition2RecommendTag
{
    XF_PUSH_URLComponent_Fast(@"bdj://essence/recommendTag")
}
@end
