//
//  BDJMediaRenderItem.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJAVPostRenderItem.h"

@implementation BDJAVPostRenderItem

- (NSString *)playCount
{
    NSInteger play_count = _playCount.integerValue;
    if (play_count > 10000) {
        // 如果是上万位的数据，保留一位小数
        CGFloat fromatNumber = floor((play_count / 10000.0) * 10) / 10;
        // 去除小数为0的情况
        if (fromatNumber - ((int)fromatNumber) >= 0.1) {
            return [NSString stringWithFormat:@"%.1f万%@",fromatNumber,@"播放"];
        }else{
            return [NSString stringWithFormat:@"%zd万%@",((int)fromatNumber),@"播放"];
        }
    }
    return [NSString stringWithFormat:@"%@%@",_playCount,@"播放"]; 
}
- (NSString *)playTimeLen
{
    NSInteger minutes = _playTimeLen.integerValue / 60;
    NSInteger seconds = _playTimeLen.integerValue % 60;
    return [NSString stringWithFormat:@"%02zd:%02zd",minutes,seconds];
}
@end
