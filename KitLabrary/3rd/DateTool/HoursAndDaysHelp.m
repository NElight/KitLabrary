//
//  HoursAndDaysHelp.m
//  SuperStar
//
//  Created by Kevin on 16/5/9.
//  Copyright © 2016年 ZhangAndLiu. All rights reserved.
//

#import "HoursAndDaysHelp.h"

@implementation HoursAndDaysHelp

////通过YYYY-MM-dd HH:mm:ss得到date
//+ (NSDate*)getDateFromString:(NSString *)str{
//    NSDateFormatter *format = [[NSDateFormatter alloc]init];
//    format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
//    return [format dateFromString:str];
//}

//通过YYYY-MM-dd HH:mm:ss得到string
+ (NSString *)getStringFromDate:(NSDate*)date{
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        format.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        return [format stringFromDate:date];
}


//*时间转换为几小时，几天

+(NSString *)hoursAndDaysWithDate:(NSString *)date{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * d = [format dateFromString:date];
    
    NSTimeInterval late = [d timeIntervalSince1970]*1;
    
    NSString * timeString = nil;
    
    NSDate * dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval now = [dat timeIntervalSince1970]*1;
    
    NSTimeInterval cha = now - late;
    if (cha/3600 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num= [timeString intValue];
        
        if (num <= 1) {
            
//            timeString = [NSString stringWithFormat:@"刚刚..."];
            timeString = [NSString stringWithFormat:@"今天"];
            
        }else{
            
//            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
            timeString = [NSString stringWithFormat:@"今天"];
        }
        
    }
    
    if (cha/3600 > 1 && cha/86400 < 1) {
        
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
//        timeString = [NSString stringWithFormat:@"今天"];
        
    }
    
    if (cha/86400 > 1)
        
    {
        
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        
        timeString = [timeString substringToIndex:timeString.length-7];
        
        int num = [timeString intValue];
        
        if (num < 2) {
            
            timeString = [NSString stringWithFormat:@"昨天"];
            
        }else if(num == 2){
            
            timeString = [NSString stringWithFormat:@"前天"];
            
        }else if (num > 2 && num <7){
            
            timeString = [NSString stringWithFormat:@"%@天前", timeString];
            
        }else if (num >= 7 && num <= 10) {
            
            timeString = [NSString stringWithFormat:@"1周前"];
            
        }else if(num > 10){
            
            timeString = [NSString stringWithFormat:@"n天前"];
            
        }
        
    }
    return timeString;
}

+(NSString *)timeFromToday:(NSString *)date{
//    NSDate *todayDate = [self getNowDateFromatAnDate:[NSDate date]];
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *todayStr = [format stringFromDate:todayDate];
    NSString *today = [todayStr substringToIndex:7];
    NSString *dayStr = [date substringToIndex:7];
    
    NSComparisonResult res = [today compare:dayStr];
    if (res == NSOrderedAscending) {
        return [date substringWithRange:NSMakeRange(5, 5)];
    }else if (res == NSOrderedDescending) {
        return [date substringWithRange:NSMakeRange(5, 5)];
    }else if (res == NSOrderedSame) {
        
        NSInteger todayN = [[todayStr substringWithRange:NSMakeRange(8, 2)] integerValue];
        NSInteger dayN = [[date substringWithRange:NSMakeRange(8, 2)] integerValue];
        
        if (todayN == dayN) {
            return @"今天";
        }else if (todayN > dayN) {
            
            if (todayN - dayN == 1) {
                return @"昨天";
            }else if (todayN - dayN == 2) {
                return @"前天";
            }else {
                return [date substringWithRange:NSMakeRange(5, 5)];
            }
            
        }else if (todayN < dayN) {
            
            if (dayN - todayN == 1) {
                return @"明天";
            }else if (dayN - todayN == 2) {
                return @"后天";
            }else {
                return [date substringWithRange:NSMakeRange(5, 5)];
            }
        }else{
            return nil;
        }
        
        
    }else {
        return nil;
    }
    
    
}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate

{
    
    //设置源日期时区
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];//或UTC
//    NSTimeZone *sourceTimeZone = [NSTimeZone systemTimeZone];
    
    //设置转换后的目标日期时区
    
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    
    //得到源日期与世界标准时间的偏移量
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    
    //目标日期与本地时区的偏移量
    
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    
    //得到时间偏移量的差值
    
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    //转为现在时间
    
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
    
}


@end
