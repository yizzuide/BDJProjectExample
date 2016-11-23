//
//  NSDate+Extension.h
//  
//
//  Created by Yizzuide on 15/6/16.
//  Copyright © 2015年 Yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/** 是否是昨天 */
- (BOOL)isYesterday;
/** 是否是今天 */
- (BOOL)isToday;
/** 是否是今年 */
- (BOOL)isThisYear;
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/** 是否是昨天 */
+ (BOOL)isYesterdayWithCreateDate:(NSDate *)createDate now:(NSDate *)now dateFormat:(NSDateFormatter *)fmt calendar:(NSCalendar *)calendar;
/** 是否是今天 */
+ (BOOL)isTodayWithCreateDate:(NSDate *)createDate now:(NSDate *)now dateFormat:(NSDateFormatter *)fmt;
/** 是否是今年 */
+ (BOOL)isThisYearWithCreateDate:(NSDate *)createDate now:(NSDate *)now calendar:(NSCalendar *)calendar;
@end
