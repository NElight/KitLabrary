//
//  FirstOrNO.m
//  FirstApp
//
//  Created by Yioks-Mac on 16/7/28.
//
#define kOpenAppTimes @"kOpenAppTimes"

#import "FirstOrNO.h"

@implementation FirstOrNO
/**
 *  记录用户打开应用的次数
 */
+(void)recordUserOpenAppTimes {
    NSInteger times = [[NSUserDefaults standardUserDefaults]integerForKey:kOpenAppTimes];
    //把次数加1
    times++;
    [[NSUserDefaults standardUserDefaults]setInteger:times forKey:kOpenAppTimes];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  是否是第一次打开应用
 *
 */
+(BOOL)isFirstOpen {
    NSInteger times = [[NSUserDefaults standardUserDefaults]integerForKey:kOpenAppTimes];
    if (times == 1) {
        return  YES;
    }else return NO;
}
/**
 *  返回用户打开应用的次数
 *
 *  @return 打开应用的次数
 */
+(NSInteger)openAppTimes {
    NSInteger times = [[NSUserDefaults standardUserDefaults]integerForKey:kOpenAppTimes];
    return times;
}
@end
