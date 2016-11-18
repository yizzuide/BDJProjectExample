//
//  XMGPushGuideLoader.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPushGuideLoader.h"
#import "XMGPushGuideView.h"
#import <MTMigration.h>

@implementation XMGPushGuideLoader

+ (void)showPushGuideViewOnWindow:(UIWindow *)window
{
    // 更新版本时再一次显示
    [MTMigration applicationUpdateBlock:^{
        XMGPushGuideView *pushGuideView = [XMGPushGuideView pushGuideView];
        pushGuideView.frame = window.bounds;
        [window addSubview:pushGuideView];
    }];
}
@end
