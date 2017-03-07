//
//  AFHTTPSessionManager+SharedManager.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/10/13.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "AFHTTPSessionManager+SharedManager.h"

@implementation AFHTTPSessionManager (SharedManager)

+ (instancetype)sharedManager {
    static AFHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
    });
    return manager;
}

@end
