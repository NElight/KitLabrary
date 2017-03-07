//
//  UserInfoSaveManager.m
//  模块封装
//
//  Created by Yioks-Mac on 16/7/29.
//  Copyright © 2016年 Yioks-Mac. All rights reserved.
//

#import "UserInfoSaveManager.h"

@implementation UserInfoSaveManager

+ (BOOL)saveData:(id)data plistNamed:(NSString *)pName atDir:(NSString *)dir
{
    return [self saveData:data dataNamed:pName plistNamed:pName atDir:dir];
}

+ (id)dataPlistNamed:(NSString*)pName atDir:(NSString*)dir
{
    if (![pName isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSString *path_ = [dir stringByAppendingPathComponent:[self convertPlistName:pName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path_])
    {
        return nil;
    }
    else
    {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path_];
        if ([tempDictionary isKindOfClass:[NSDictionary class]]
            && tempDictionary.allKeys.count == 1
            && [tempDictionary objectForKey:pName]) {
            
            return [tempDictionary objectForKey:pName];
        }
        else {
            return tempDictionary;
        }
    }
}

+ (BOOL)saveData:(id)data dataNamed:(NSString*)dataName plistNamed:(NSString*)pName atDir:(NSString*)dir
{
    if (!data || [data isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if (![dataName isKindOfClass:[NSString class]] || ![pName isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    dir = [self createDirPath:dir];
    NSString *path_ = [dir stringByAppendingPathComponent:[self convertPlistName:pName]];
    
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path_];
    if(!tempDictionary)
    {
        tempDictionary = [[NSMutableDictionary alloc] init];
    }
    
    [tempDictionary setValue:data forKey:dataName];
    return [tempDictionary writeToFile:path_ atomically:YES];
    
}

+ (id)dataOfDataNamed:(NSString*)dataName plistNamed:(NSString*)pName atDir:(NSString*)dir;
{
    
    if (![dataName isKindOfClass:[NSString class]] || ![pName isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSString *path_ = [dir stringByAppendingPathComponent:[self convertPlistName:pName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path_])
    {
        return nil;
    }
    else
    {
        NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path_];
        if (![tempDictionary isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        
        return [tempDictionary objectForKey:dataName];
    }
}

+ (BOOL)deleteDataAtDir:(NSString*)dir
{
    // 删除文件夹及文件级内的文件：
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:dir error:nil];
}

+ (BOOL)deleteDataPlistNamed:(NSString*)pName ofDir:(NSString*)dir
{
    if (![pName isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    NSString *path_ = [dir stringByAppendingPathComponent:[self convertPlistName:pName]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path_])
    {
        return YES;
    }
    
    return [fileManager removeItemAtPath:path_ error:nil];
}

+ (BOOL)deleteDataNamed:(NSString*)dataName ofPlistName:(NSString*)pName ofDir:(NSString*)dir
{
    if (![dataName isKindOfClass:[NSString class]] || ![pName isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    NSString *path_ = [dir stringByAppendingPathComponent:[self convertPlistName:pName]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path_])
    {
        return YES;
    }
    NSMutableDictionary *tempDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:path_];
    
    [tempDictionary removeObjectForKey:dataName];
    
    return [tempDictionary writeToFile:path_ atomically:YES];
    
}

#pragma mark - UserDefault
+ (BOOL)saveData:(id)data toUserDefaultKeyed:(NSString*)key
{
    if (![key isKindOfClass:[NSString class]]) {
        return NO;
    }
    
    if (!data || [data isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    NSUserDefaults *muDefault = [NSUserDefaults standardUserDefaults];
    [muDefault setObject:data forKey:key];
    return [muDefault synchronize];
}

+ (id)dataOfUserDefaultKeyed:(NSString*)key
{
    if (![key isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    NSUserDefaults *muDefault = [NSUserDefaults standardUserDefaults];
    id data = [muDefault objectForKey:key];
    
    if (!data || [data isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return data;
}

+ (BOOL)deleteUserDefaultDataKeyed:(NSString *)key
{
    if (![key isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    NSUserDefaults *muDefault = [NSUserDefaults standardUserDefaults];
    [muDefault removeObjectForKey:key];
    return [muDefault synchronize];
}

#pragma mark - - Private Methods
+ (NSString*)convertPlistName:(NSString*)pName
{
    if ([pName hasSuffix:@".plist"]) {
        return pName;
    }
    return [pName stringByAppendingString:@".plist"];
}

#pragma mark - - 创建文件路径

+ (NSString*)createDirPath:(NSString*)dirPath
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    // 表示这不是一个目录，或者这个目录不存在，则创建该目录
    if ( !(isDir == YES && existed == YES) )
    {
        if (![fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil]) {
            return nil;
        }
    }
    return dirPath;
}

+ (BOOL)clearDataAtDirPath:(NSString *)dirPath
{
    //    删除文件夹及文件级内的文件：
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:dirPath error:nil];
}

+(NSString *)docPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+(NSString *)docPathWithSubPath:(NSString *)subPath{
    NSString *docPath = [self docPath];
    return [docPath stringByAppendingPathComponent:subPath];
}


@end
