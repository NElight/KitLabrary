//
//  CleanCacheManager.h
//  Unity-iPhone
//
//  Created by Mac on 16/8/15.
//
//

#import <Foundation/Foundation.h>

@interface CleanCacheManager : NSObject

+ (instancetype)sharedManager;

- (CGFloat)cleanCache;

@end
