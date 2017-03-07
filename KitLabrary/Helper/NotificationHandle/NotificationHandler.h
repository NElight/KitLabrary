//
//  NotificationHandler.h
//  UnityFootball
//
//  Created by Yioks-Mac on 17/2/6.
//  Copyright © 2017年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface NotificationHandler : NSObject<UNUserNotificationCenterDelegate>

+ (instancetype)sharedHandler;

- (void)requestAuthorizationWithCompletionHandler:(void (^)(BOOL granted, NSError *__nullable error))completionHandler;

- (void)registerNotificationCategory;

+ (void)addLocalNotification;

@end
