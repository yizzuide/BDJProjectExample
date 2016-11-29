//
//  BDJPostRenderItem.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostRenderItem.h"
#import "NSDate+Extension.h"

@implementation BDJPostRenderItem

- (NSString *)love
{
    return [self formatNumberString:_love placeholder:@"赞"];
}

- (NSString *)hate
{
    return [self formatNumberString:_hate placeholder:@"踩"];
}

- (NSString *)rePost
{
    return [self formatNumberString:_rePostCount placeholder:@"转"];
}

- (NSString *)comment
{
    return [self formatNumberString:_commentCount placeholder:@"评"];
}

- (NSString *)createTime
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_createTime];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _createTime;
    }
}
            
- (NSString *)formatNumberString:(NSString *)numberString placeholder:(NSString *)placeholder
{
    NSInteger number = numberString.integerValue;
    if (!number) {
        return placeholder;
    }
    return numberString;
}

- (NSString *)topCmtContent
{
    if (!_topCmtContent) return nil;
    return [NSString stringWithFormat:@"%@：%@",_topCmtUserName,_topCmtContent];
}
@end
