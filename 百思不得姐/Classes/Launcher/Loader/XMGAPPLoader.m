//
//  XMGAPPLoader.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGAPPLoader.h"
#import "XMGPushGuideLoader.h"

@implementation XMGAPPLoader

+ (void)loadForWindow:(UIWindow *)window
{
    [XMGPushGuideLoader showPushGuideViewOnWindow:window];
}
+ (void)loadForLaunchOptions:(NSDictionary *)launchOptions
{
    
}
+ (void)loadForGlobal
{
    
}
@end
