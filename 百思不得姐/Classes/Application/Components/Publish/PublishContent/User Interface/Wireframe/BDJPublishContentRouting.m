//
//  BDJPublishContentRouting.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/15.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJPublishContentRouting.h"

@implementation BDJPublishContentRouting

// 组装模块
XF_AutoAssemblyModule_Fast

// 跳转组件
- (void)transition2TopicTag
{
    XF_PUSH_URLComponent_Fast(@"bdj://indexTab/publish/publishContent/topicTag")
}
@end
