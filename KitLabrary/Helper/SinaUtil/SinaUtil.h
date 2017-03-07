//
//  SinaUtil.h
//  UnityFootball
//
//  Created by Yioks-Mac on 17/1/19.
//  Copyright © 2017年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"

@interface SinaUtil : NSObject<WeiboSDKDelegate>

+ (instancetype)sharedManager;

- (void)shareSinaWeiboWithText:(NSString *)text;

- (void)shareSinaWeiboWithText:(NSString *)text withImage:(UIImage *)image;

- (void)shareSinaWeiboWithText:(NSString *)text title:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)image withUrlStr:(NSString *)urlStr;

@end
