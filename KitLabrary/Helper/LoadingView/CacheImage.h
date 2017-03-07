//
//  CacheImage.h
//  UnityFootball
//
//  Created by Yioks-Mac on 16/8/26.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheImage : NSObject

+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

@end
