//
//  NSJSONSerialization+ZGJSON.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/10/24.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "NSJSONSerialization+ZGJSON.h"

@implementation NSJSONSerialization (ZGJSON)

+ (nullable NSString *)stringWithJSONObject:(nonnull id)JSONObject
{
    if (![NSJSONSerialization isValidJSONObject:JSONObject]){
        NSLog(@"The JSONObject is not JSON Object");
        return nil;
    }
    NSData *data = [NSJSONSerialization dataWithJSONObject:JSONObject options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
}

+ (nullable id)objectWithJSONString:(nonnull NSString *)JSONString
{
    NSData *data = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    return [self objectWithJSONData:data options:NSJSONReadingMutableContainers];
}

+ (nullable id)objectWithJSONData:(nonnull NSData *)JSONData
{
    return [self objectWithJSONData:JSONData options:NSJSONReadingMutableContainers];
}

+ (nullable id)objectWithJSONData:(nonnull NSData *)JSONData options:(NSJSONReadingOptions)option
{
    NSError *error;
    id JSONObject = [NSJSONSerialization JSONObjectWithData:JSONData options:option error:&error];
    
    return JSONObject;
}

@end
