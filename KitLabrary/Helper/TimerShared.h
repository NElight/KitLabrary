//
//  TimerShared.h
//  UnityFootball
//
//  Created by PingXuhui on 16/11/8.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimerDelegate <NSObject>

- (void)timerValue:(NSString *)timerStr;

@end

@interface TimerShared : NSObject

@property (nonatomic) NSTimer *timer;

@property (nonatomic, assign) NSInteger hours;
@property (nonatomic, assign) NSInteger minutes;
@property (nonatomic, assign) NSInteger seconds;

@property (nonatomic, weak) id <TimerDelegate> delegate;

+ (id)sharedManager;

+ (NSString *)timerStr;

@end
