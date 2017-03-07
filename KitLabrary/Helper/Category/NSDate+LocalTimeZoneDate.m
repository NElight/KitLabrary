//
//  NSDate+LocalTimeZoneDate.m
//  YioksFootball-Test
//
//  Created by Yioks-Mac on 16/8/20.
//  Copyright © 2016年 PingXuhui. All rights reserved.
//

#import "NSDate+LocalTimeZoneDate.h"

@implementation NSDate (LocalTimeZoneDate)

-(instancetype)switchToGMTDate{
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    
    NSTimeInterval time = [zone secondsFromGMTForDate:self];// 以秒为单位返回当前时间与系统格林尼治时间的差
    
    NSDate *dateNow = [self dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    return dateNow;
}

@end
