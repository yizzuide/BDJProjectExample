//
//  BDJAPPLoader.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJAPPLoader.h"
#import "BDJPushGuideLoader.h"

@implementation BDJAPPLoader

+ (void)loadForWindow:(UIWindow *)window
{
    [BDJPushGuideLoader showPushGuideViewOnWindow:window];
}
+ (void)loadForLaunchOptions:(NSDictionary *)launchOptions
{
    
}
+ (void)loadForGlobal
{
    
}
@end
