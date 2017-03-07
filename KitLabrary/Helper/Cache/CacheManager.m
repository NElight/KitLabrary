//
//  CacheManager.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/10/24.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "CacheManager.h"

@interface CacheManager (){
    NSString *_diskPath;
    NSMutableDictionary *_responseInfoDict;
}

@end

@implementation CacheManager

//- (instancetype)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path {
//    if (self = [super initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path]) {
//        if (!path) {
//            _diskPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//            _responseInfoDict = [NSMutableDictionary dictionaryWithCapacity:0];
//        }else {
//            _diskPath = path;
//        }
//    }
//    return self;
//}
//
//- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
//    NSLog(@"%@", request.HTTPMethod);
//    if ([request.HTTPMethod compare:@"GET"] != NSOrderedSame) {
//        
//        return [super cachedResponseForRequest:request];
//        
//    }else{
//        
//        return [self KL_CacheResponseDataFromRequest:request];
//        
//    }
//    
//    
//}
//
//- (NSCachedURLResponse *)KL_CacheResponseDataFromRequest:(NSURLRequest *)request {
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        if (response && data) {
//            
//            [self.responseInfoDict removeObjectForKey:fileName];
//            
//        }
//        
//        if (error) {
//            
//            cachedResponse = nil;
//            
//        }
//        
//        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f", [date timeIntervalSince1970]], @"time",response.MIMEType,@"MIMEType",response.textEncodingName,@"textEncodingName" ,nil];
//        
//        [dict writeToFile:otherInfoPath atomically:YES];
//        
//        [data writeToFile:filePath atomically:YES];
//        
//        cachedResponse = [[NSCachedURLResponse alloc]initWithResponse:response data:data];
//        
//    }];
//}


@end
