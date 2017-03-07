//
//  UMUtility.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/11/11.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "UMUtility.h"

@implementation UMUtility

+ (void)UMConfig:(UIApplication *)application launchingOptions:(NSDictionary *)launchOptions {
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"58256d42a325115c600000e5";
    UMConfigInstance.channelId = nil;
    [MobClick startWithConfigure:UMConfigInstance];
}

@end
