//
//  BDJPushGuideLoader.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPushGuideLoader.h"
#import "BDJPushGuideView.h"
#import <MTMigration.h>

@implementation BDJPushGuideLoader

+ (void)showPushGuideViewOnWindow:(UIWindow *)window
{
    // 更新版本时再一次显示
    [MTMigration applicationUpdateBlock:^{
        BDJPushGuideView *pushGuideView = [BDJPushGuideView pushGuideView];
        pushGuideView.frame = window.bounds;
        [window addSubview:pushGuideView];
    }];
}
@end
