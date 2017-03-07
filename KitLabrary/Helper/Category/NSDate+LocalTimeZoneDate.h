//
//  NSDate+LocalTimeZoneDate.h
//  YioksFootball-Test
//
//  Created by Yioks-Mac on 16/8/20.
//  Copyright © 2016年 PingXuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LocalTimeZoneDate)

//转换成北京时间
- (instancetype)switchToGMTDate;

@end
