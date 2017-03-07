//
//  MatchDB.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/12/13.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "MatchDB.h"
#import <sqlite3.h>

@interface MatchDB (){
    sqlite3 *_db;
}



@end

@implementation MatchDB

+ (instancetype)sharedManager {
    static MatchDB *matchDB;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        matchDB = [[MatchDB alloc]init];
    });
    return matchDB;
}

- (BOOL)createDatabase {
    NSString *str = @"match.sqlite";
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:str];
    
    int status = sqlite3_open(fileName.UTF8String, &_db);
    if (status == SQLITE_OK) {
        
        NSString *sql = @"create table if not exists Match(token text primary key, start_time text, pause_time text, pause_space text, fight_status text, skip_time text, isManual text";
        
        char *errmeg = NULL;
        
        sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmeg);
        if (!errmeg) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}

- (BOOL)createTableWithName:(NSString *)tableName{
    NSString *str = @"match.sqlite";
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:str];
    
    int status = sqlite3_open(fileName.UTF8String, &_db);
    if (status == SQLITE_OK) {
        
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@(token text, start_time text, pause_time text, pause_space text, fight_status text, skip_time text, isManual text)", tableName];
        
        char *errmeg = NULL;
        
        sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmeg);
        if (!errmeg) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}

- (BOOL)hasMatchWithToken:(NSString *)token {
    
    NSString *sql = [NSString stringWithFormat:@"select * from Match where token='%@'", token];
    
    if (sql) {
        sqlite3_stmt *stmt = NULL;
        int status = sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL);
        if (status == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                return YES;
            }
            
            return NO;
        }else {
            return NO;
        }
        
    }else {
        return NO;
    }
}

- (BOOL)insertMatch:(FightStateModel *)model {
    
    NSString *sql = [NSString stringWithFormat:@"insert into Match(token, start_time, pause_time, pause_space, fight_status, skip_time, isManual) values('%@','%@','%@','%@','%@','%@','%@')", model.token, model.fightStartTime, model.fightPauseTime, model.fightPauseSpace, model.fightStatus, model.fightSkipTime, model.isManual];
    
    
    if (sql) {
        char *errmsg = NULL;
        sqlite3_exec(_db, sql.UTF8String, nil, nil, &errmsg);
        if (!errmsg) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}

- (BOOL)deleteMatch:(NSString *)token {
    NSString *sql = [NSString stringWithFormat:@"delete * from Match where token='%@'", token];
    if (sql) {
        char *errmsg = NULL;
        sqlite3_exec(_db, sql.UTF8String, nil, nil, &errmsg);
        if (!errmsg) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}

- (FightStateModel *)searchMatchFromToken:(NSString *)token{
    
    NSString *sql = [NSString stringWithFormat:@"select * from Match where token='%@'", token];
    
    if (sql) {
        sqlite3_stmt *stmt = NULL;
        int status = sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL);
        if (status == SQLITE_OK) {
            while (sqlite3_step(stmt) == SQLITE_ROW) {
                char *token = (char*)sqlite3_column_text(stmt, 0);
                char *startTime = (char*)sqlite3_column_text(stmt, 1);
                char *pauseTime = (char *)sqlite3_column_text(stmt, 2);
                char *pauseSpace = (char *)sqlite3_column_text(stmt, 3);
                char *fightStatus = (char *)sqlite3_column_text(stmt, 4);
                char *fightSkipTime = (char *)sqlite3_column_text(stmt, 5);
                char *isManual = (char *)sqlite3_column_text(stmt, 6);
                FightStateModel *model = [[FightStateModel alloc]init];
                model.token = [NSString stringWithUTF8String:token];
                model.fightStartTime = [NSString stringWithUTF8String:startTime];
                model.fightPauseTime = [NSString stringWithUTF8String:pauseTime];
                model.fightPauseSpace = [NSString stringWithUTF8String:pauseSpace];
                model.fightStatus = [NSString stringWithUTF8String:fightStatus];
                model.fightSkipTime = [NSString stringWithUTF8String:fightSkipTime];
                model.isManual = [NSString stringWithUTF8String:isManual];
                return model;
            }
            return nil;
        }else {
            return nil;
        }
        
    }else {
        return nil;
    }
}


- (BOOL)updateMatch:(FightStateModel *)model {
    NSString *sql = [NSString stringWithFormat:@"UPDATE Match SET start_time='%@', pause_time='%@', pause_space='%@', fight_status='%@', skip_time='%@', isManual='%@' WHERE token='%@'",  model.fightStartTime, model.fightPauseTime, model.fightPauseSpace, model.fightStatus, model.fightSkipTime, model.isManual, model.token];
    
    
    if (sql) {
        char *errmsg = NULL;
        sqlite3_exec(_db, sql.UTF8String, nil, nil, &errmsg);
        if (!errmsg) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}



/// 获取当前类的所有属性
+ (NSArray *)getAttributeListWithClass:(id)className {
    // 记录属性个数
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([className class], &count);
    NSMutableArray *tempArrayM = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSAssert(![name isEqualToString:@"index"], @"禁止在model中使用index作为属性,否则会引起语法错误");
        if ([name isEqualToString:@"hash"]) {
            break;
        }
        [tempArrayM addObject:name];
    }
    free(properties);
    return [tempArrayM copy];
}

/// OC类型转SQL类型
+ (NSString *)OCConversionTyleToSQLWithString:(NSString *)String {
    if ([String isEqualToString:@"long"] || [String isEqualToString:@"int"] || [String isEqualToString:@"BOOL"]) {
        return @"integer";
    }
    if ([String isEqualToString:@"NSData"]) {
        return @"blob";
    }
    if ([String isEqualToString:@"double"] || [String isEqualToString:@"float"]) {
        return @"real";
    }
    // 自定义数组标记
    if ([String isEqualToString:@"NSArray"] || [String isEqualToString:@"NSMutableArray"]) {
        return @"customArr";
    }
    // 自定义字典标记
    if ([String isEqualToString:@"NSDictionary"] || [String isEqualToString:@"NSMutableDictionary"]) {
        return @"customDict";
    }
    return @"text";
}


@end
