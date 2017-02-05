//
//  BDJNewActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJNewActivity.h"
#import "BDJNewEventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<BDJNewEventHandlerPort>)

@interface BDJNewActivity ()

@end

@implementation BDJNewActivity

#pragma mark - 初始化
// 覆盖精华里的子模块类型
- (NSArray *)moduleNames
{
    return @[@"NewAllPost",@"NewVideoPost",@"NewVoicePost",@"NewPicturePost",@"NewWordsPost"];
}


#pragma mark - UIControlDelegate




#pragma mark - Getter



@end
