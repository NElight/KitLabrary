//
//  WXUtil.h
//  UnityFootball
//
//  Created by Yioks-Mac on 17/1/18.
//  Copyright © 2017年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface WXUtil : NSObject<WXApiDelegate>

+ (instancetype)sharedManager;

- (void)shareTextMessage:(NSString *)message withScene:(int)scene;

- (void)shareImageMessage:(UIImage *)image withScene:(int)scene;

- (void)shareVideoMessage:(NSString *)title description:(NSString *)description urlStr:(NSString *)urlStr thumbImage:(UIImage *)image withScene:(int)scene;

- (void)shareNetMessage:(NSString *)title description:(NSString *)description urlStr:(NSString *)urlStr thumbImage:(UIImage *)image withScene:(int)scene;

@end
