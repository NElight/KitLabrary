//
//  XHStringOperation.m
//  YioksQRCode
//
//  Created by PingXuhui on 16/1/19.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "XHStringOperation.h"

@implementation XHStringOperation


+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (NSMutableAttributedString *)setLineSpacingString:(NSString *)textStr lineSpacing:(CGFloat)spacing textSpacing:(CGFloat)textSpacing
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:textStr attributes:@{NSKernAttributeName:@(textSpacing)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textStr length])];
    return attributedString;
}


+ (NSString *)cutString:(NSString *)str StartString:(NSString *)startStr toEndString:(NSString *)endStr
{
    NSString *pageStart = startStr;
    NSString *pageEnd = endStr;
    NSUInteger startOffset = [str rangeOfString:pageStart].location;
    NSUInteger endOffset = [str rangeOfString:pageEnd].location;
    NSString *result = [str substringWithRange:NSMakeRange(startOffset, endOffset-startOffset)];
    return result;
}

+ (NSString *)cutToEndString:(NSString *)str startString:(NSString *)startStr
{
    NSString *pageStart = startStr;
    NSUInteger startOffset = [str rangeOfString:pageStart].location;
    NSString *result = [str substringFromIndex:startOffset];
    return result;
}

+ (NSString *)getTimestamp
{
    // 把时间转为时间戳
    NSDate *localDate = [NSDate date]; //当前时间
    NSString *timeSp = [NSString stringWithFormat:@"%lld",(long long)[localDate timeIntervalSince1970] * 1000];  // 转为 UNIX 时间戳
    return timeSp;
}

+ (NSString *)formatterTime:(NSString *)format
{
    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = format;
    NSString *timeStr = [formatter stringFromDate:[NSDate date]];
    return timeStr;
}


/**
 *  获取未来某个日期是星期几
 *
 *
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}


/**
 字符串转日期

 @param dateStr <#dateStr description#>
 @param dateFormatter <#dateFormatter description#>
 @return <#return value description#>
 */
+ (NSDate *)dateFromString:(NSString *)dateStr dateFormatter:(NSString *)dateFormatter  {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatter];
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}

/**
 日期转字符串

 @param date <#date description#>
 @param dateFormatter <#dateFormatter description#>
 @return <#return value description#>
 */
+ (NSString *)stringFromDate:(NSDate *)date dateFormatter:(NSString *)dateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatter];
    NSString *strDate = [formatter stringFromDate:date];
    return strDate;
}

/**
 *  计算剩余时间
 *
 *  @param endTime   结束日期
 *
 *  @return 剩余时间
 */
+ (float)getCountDownStringWithEndTime:(NSString *)endDateStr {
    
    //结束时间
    
    NSDateFormatter*dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate*overdate = [dateFormatter dateFromString:endDateStr];
    
    NSTimeZone*zone1 = [NSTimeZone systemTimeZone];
    
    NSInteger interva1 = [zone1 secondsFromGMTForDate: overdate];
    
    NSDate*endDate = [overdate dateByAddingTimeInterval: interva1];
    
    //获取当前时间
    
    NSDate*date = [NSDate date];
    
    NSTimeZone*zone2 = [NSTimeZone systemTimeZone];
    
    NSInteger interva2 = [zone2 secondsFromGMTForDate:date];
    
    NSDate*currentDate = [date dateByAddingTimeInterval: interva2];
    
    NSLog(@"currentDate=%@ --endDate-%@",currentDate,endDate);
    
    NSTimeInterval time=[currentDate timeIntervalSinceDate:endDate];
    
    NSLog(@"-=========%f",time);
    return time;
}


@end
