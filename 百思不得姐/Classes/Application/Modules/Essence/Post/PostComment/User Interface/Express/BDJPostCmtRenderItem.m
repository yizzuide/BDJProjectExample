//
//  BDJPostCmtRenderItem.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/11/30.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostCmtRenderItem.h"

@implementation BDJPostCmtRenderItem

- (NSString *)likeCount
{
    NSInteger like_count = _likeCount.integerValue;
    if (like_count > 10000) {
        // 如果是上万位的数据，保留一位小数
        CGFloat fromatNumber = floor((like_count / 10000.0) * 10) / 10;
        // 去除小数为0的情况
        if (fromatNumber - ((int)fromatNumber) >= 0.1) {
            return [NSString stringWithFormat:@"%.1f万",fromatNumber];
        }else{
            return [NSString stringWithFormat:@"%zd万",((int)fromatNumber)];
        }
    }
    return _likeCount;
}

- (NSAttributedString *)autoDelectAtCmtContent
{
    if (!_commentContent) {
        return nil;
    }
    if (_refUserName.length) {
        NSMutableAttributedString *mAttr = [[NSMutableAttributedString alloc] initWithString:_commentContent];
        ;
        NSString *atUserName = [NSString stringWithFormat:@"@%@ ",_refUserName];
        NSAttributedString *atUserAttr = [[NSAttributedString alloc] initWithString:atUserName attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
        [mAttr insertAttributedString:atUserAttr atIndex:0];
        return mAttr;
    }
    return [[NSAttributedString alloc] initWithString:_commentContent];
}

- (NSString *)voiceSecond
{
    return [NSString stringWithFormat:@"%@''",_voiceSecond];
}
@end
