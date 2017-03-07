//
//  UserInfoSaveManager.h
//  模块封装
//
//  Created by Yioks-Mac on 16/7/29.
//  Copyright © 2016年 Yioks-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoSaveManager : NSObject

// 默认plist文件中，根节点的名称和plistName是相同的
+ (BOOL)saveData:(id)data plistNamed:(NSString*)pName atDir:(NSString*)dir;

// 将plist文件中根节点对应的数据取出来（前提是plist文件名和根节点名是相同的）
// 如果根节点名和plist文件名不同，或者plist文件不存在根节点，则将plist文件中的所有数据全部取出来
+ (id)dataPlistNamed:(NSString*)pName atDir:(NSString*)dir;

// 保存到plist
+ (BOOL)saveData:(id)data dataNamed:(NSString*)dataName plistNamed:(NSString*)pName atDir:(NSString*)dir;
+ (id)dataOfDataNamed:(NSString*)dataName plistNamed:(NSString*)pName atDir:(NSString*)dir;

+ (BOOL)deleteDataAtDir:(NSString*)dir;     // 删除该目录下得所有文件
+ (BOOL)deleteDataPlistNamed:(NSString*)pName ofDir:(NSString*)dir;
+ (BOOL)deleteDataNamed:(NSString*)dataName ofPlistName:(NSString*)pName ofDir:(NSString*)dir;

// 保存到系统提供的plist(即userDefault)
+ (BOOL)saveData:(id)data toUserDefaultKeyed:(NSString*)key;
+ (id)dataOfUserDefaultKeyed:(NSString*)key;
+ (BOOL)deleteUserDefaultDataKeyed:(NSString*)key;


#pragma mark - - 创建文件路径
+ (NSString*)createDirPath:(NSString*)dirPath;
+ (BOOL)clearDataAtDirPath:(NSString *)dirPath;

#pragma mark - - 沙盒路径
+ (NSString*)docPath;
+ (NSString*)docPathWithSubPath:(NSString*)subPath;

@end
