//
//  NSJSONSerialization+ZGJSON.h
//  UnityFootball
//
//  Created by Yioks-Mac on 16/10/24.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (ZGJSON)

+ (nullable NSString *)stringWithJSONObject:(nonnull id)JSONObject;
+ (nullable id)objectWithJSONString:(nonnull NSString *)JSONString;
+ (nullable id)objectWithJSONData:(nonnull NSData *)JSONData;

@end
