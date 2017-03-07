//
//  QQUtil.h
//  UnityFootball
//
//  Created by Yioks-Mac on 17/1/18.
//  Copyright © 2017年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>

@interface QQUtil : NSObject<TencentSessionDelegate, QQApiInterfaceDelegate>


+ (instancetype)sharedManager;

- (void)loginWithQQ;

//分享不需要登录
- (void)shareMessage:(id)message;

@end
