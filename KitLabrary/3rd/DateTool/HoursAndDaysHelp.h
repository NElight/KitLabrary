//
//  HoursAndDaysHelp.h
//  SuperStar
//
//  Created by Kevin on 16/5/9.
//  Copyright © 2016年 ZhangAndLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HoursAndDaysHelp : NSObject

//通过YYYY-MM-dd HH:mm:ss得到date
//+ (NSDate*)getDateFromString:(NSString *)str;

//通过YYYY-MM-dd HH:mm:ss得到string
+ (NSString *)getStringFromDate:(NSDate*)date;


+(NSString *)hoursAndDaysWithDate:(NSString *)date;


+(NSString *)timeFromToday:(NSString *)date;

@end
