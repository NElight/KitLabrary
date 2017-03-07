//
//  AFHTTPSessionManager+SharedManager.h
//  UnityFootball
//
//  Created by Yioks-Mac on 16/10/13.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AFHTTPSessionManager (SharedManager)

+(instancetype)sharedManager;

@end
