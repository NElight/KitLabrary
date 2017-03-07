//
//  CacheManager.h
//  UnityFootball
//
//  Created by Yioks-Mac on 16/10/24.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSURLCache

@property (nonatomic, strong) NSMutableDictionary *responseInfoDict;

@property (nonatomic, copy) NSString *diskPath;

@end
