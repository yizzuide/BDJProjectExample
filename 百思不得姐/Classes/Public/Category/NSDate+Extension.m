//
//  NSDate+Extension.m
//
//
//  Created by Yizzuide on 15/6/16.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


- (BOOL)isYesterday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 去掉最后的时间
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *noTimeCreateDate = [fmt stringFromDate:self];
    NSString *noTimeNowDate = [fmt stringFromDate:now];
    // 再比较天数,这样可以防止相差没满24小时,达不到一天,但实际已经到了第二天(如:9-10 21:20 ~ 9-11 7:20,它们相着没有24小时,所以day为0)
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[fmt dateFromString:noTimeCreateDate]  toDate:[fmt dateFromString:noTimeNowDate] options:0];
    
    return components.year == 0 && components.month == 0 && components.day == 1;

}
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 去掉最后的时间
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *noTimeCreateDate = [fmt stringFromDate:self];
    NSString *noTimeNowDate = [fmt stringFromDate:now];
    // 判断是否日期相同
    return [noTimeCreateDate isEqualToString:noTimeNowDate];
}

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *createYearComponent = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *visitYearComponent = [calendar components:NSCalendarUnitYear fromDate:now];
    return createYearComponent.year == visitYearComponent.year;
}

- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 比较时间
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:0];
}






/** 是否是昨天 */
+ (BOOL)isYesterdayWithCreateDate:(NSDate *)createDate now:(NSDate *)now dateFormat:(NSDateFormatter *)fmt calendar:(NSCalendar *)calendar
{
    // 去掉最后的时间
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *noTimeCreateDate = [fmt stringFromDate:createDate];
    NSString *noTimeNowDate = [fmt stringFromDate:now];
    // 再比较天数,这样可以防止相差没满24小时,达不到一天,但实际已经到了第二天(如:9-10 21:20 ~ 9-11 7:20,它们相着没有24小时,所以day为0)
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[fmt dateFromString:noTimeCreateDate]  toDate:[fmt dateFromString:noTimeNowDate] options:0];
    
    return components.year == 0 && components.month == 0 && components.day == 1;
}
/** 是否是今天 */
+ (BOOL)isTodayWithCreateDate:(NSDate *)createDate now:(NSDate *)now dateFormat:(NSDateFormatter *)fmt
{
    // 去掉最后的时间
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *noTimeCreateDate = [fmt stringFromDate:createDate];
    NSString *noTimeNowDate = [fmt stringFromDate:now];
    // 判断是否日期相同
    return [noTimeCreateDate isEqualToString:noTimeNowDate];
}
/** 是否是今年 */
+ (BOOL)isThisYearWithCreateDate:(NSDate *)createDate now:(NSDate *)now calendar:(NSCalendar *)calendar
{
    NSDateComponents *createYearComponent = [calendar components:NSCalendarUnitYear fromDate:createDate];
    
    NSDateComponents *visitYearComponent = [calendar components:NSCalendarUnitYear fromDate:now];
    return createYearComponent.year == visitYearComponent.year;
}
@end
