//
//  TimerShared.m
//  UnityFootball
//
//  Created by PingXuhui on 16/11/8.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "TimerShared.h"

volatile static TimerShared *singleInstance = nil;

@implementation TimerShared

+ (id)sharedManager {
    if (singleInstance == nil) {
        @synchronized (self) {
            if (singleInstance == nil) {
                singleInstance = [[TimerShared alloc] init];
            }
        }
    }
    return singleInstance;
}

- (instancetype)init {    
    @synchronized (self) {
        //创建计时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
        return self;
    }
}

- (void)timerAction:(NSTimer *)timer {
    self.seconds++;
    NSLog(@"timer : %ld",(long)self.seconds);
    
    if (self.seconds == 60) {
        self.minutes++;
        self.seconds = 0;
    }
    if (self.minutes == 60) {
        self.hours++;
        self.minutes = 0;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(timerValue:)]) {
        [self.delegate timerValue:[TimerShared timerStr]];
    }
//    [TimerShared timerStr];
}

+ (NSString *)timerStr {

    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",[[TimerShared sharedManager] hours], [[TimerShared sharedManager] minutes], [[TimerShared sharedManager] seconds]];
}


@end
