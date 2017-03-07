//
//  XHStringOperation.h
//  YioksQRCode
//
//  Created by PingXuhui on 16/1/19.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XHStringOperation : NSObject


/**
 *  字符串操作,判断字符串是否为空
 *
 *  @param string 要判断的字符串
 *
 *  @return 返回值：真或假
 */

+ (BOOL) isBlankString:(NSString *)string;

/**
 *  行间距设置 spacing：大小 textSpacing：字体间距
 */
+ (NSMutableAttributedString *)setLineSpacingString:(NSString *)textStr lineSpacing:(CGFloat)spacing textSpacing:(CGFloat)textSpacing;

/**
 *  从一个字符串截取到另一个字符串
 *
 *  @param str      要截取的字符串
 *  @param startStr 开始截取的字符串
 *  @param endStr   结束截取字符串之后的字符串
 *
 *  @return 截取好的字符串
 */
+ (NSString *)cutString:(NSString *)str StartString:(NSString *)startStr toEndString:(NSString *)endStr;

/**
 *  从某个字符串截取到最后
 *  @param str   要截取的字符串
 *  @param startStr  开始截取的字符串
 * 
 *  @return  截取好的字符串
 */
+ (NSString *)cutToEndString:(NSString *)str startString:(NSString *)startStr;

/**
 *  时间戳
 */
+ (NSString *)getTimestamp;

/**
 *  格式化时间
 *
 *  @param format 格式化样式
 *
 *  @return 返回格式化后的时间 
 */
+ (NSString *)formatterTime:(NSString *)format;

/**
 *  获取未来某个日期是星期几
 *
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

/**
 字符串转日期
 
 @param dateStr <#dateStr description#>
 @param dateFormatter <#dateFormatter description#>
 @return <#return value description#>
 */
+ (NSDate *)dateFromString:(NSString *)dateStr dateFormatter:(NSString *)dateFormatter;

/**
 日期转字符串
 
 @param date <#date description#>
 @param dateFormatter <#dateFormatter description#>
 @return <#return value description#>
 */
+ (NSString *)stringFromDate:(NSDate *)date dateFormatter:(NSString *)dateFormatter;

/**
 *  计算剩余时间
 *
 *  @param endTime   结束日期
 *
 *  @return 剩余时间
 */
+ (float)getCountDownStringWithEndTime:(NSString *)endDateStr;

@end
