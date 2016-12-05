//
//  BDJIndexTabRouting.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//


#import "BDJIndexTabRouting.h"

@implementation BDJIndexTabRouting

// 组装模块
XF_AutoAssemblyModule_Fast

// 跳转组件
- (void)transition2Publish
{
    // 自定义跳转
   [self.uiBus openURL:@"BDJ://indexTab/publish" withTransitionBlock:^(__kindof UIViewController *thisInterface, __kindof UIViewController *nextInterface) {
       // 使用不带动画的方式
       [thisInterface presentViewController:nextInterface animated:NO completion:nil];
   } customCode:nil];
}
@end
