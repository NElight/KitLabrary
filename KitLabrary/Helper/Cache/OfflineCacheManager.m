//
//  OfflineCacheManager.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/10/29.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "OfflineCacheManager.h"

@implementation OfflineCacheManager

+ (void)deleteOfflineFile {
    NSString *extension = @"sqlite";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //清除离线缓存
    NSString *fileDic = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSArray *contents
    = [fileManager contentsOfDirectoryAtPath:fileDic error:NULL];
    NSEnumerator *e
    = [contents objectEnumerator];
    NSString *filename;
    while ((filename
            = [e nextObject])) {
        
        if (![[filename
              pathExtension] isEqualToString:extension]) {
            
            [fileManager
             removeItemAtPath:[fileDic stringByAppendingPathComponent:filename] error:NULL];
        }
    }
}

@end
