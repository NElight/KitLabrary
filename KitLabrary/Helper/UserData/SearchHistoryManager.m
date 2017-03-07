//
//  SearchHistoryManager.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/10/26.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "SearchHistoryManager.h"
#import <sqlite3.h>

@interface SearchHistoryManager (){
    sqlite3 *_db;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SearchHistoryManager

+(instancetype)sharedManager{
    static SearchHistoryManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SearchHistoryManager alloc]init];
    });
    return manager;
}

-(instancetype)init{
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    
    return self;
}

-(BOOL)createDataBaseWithName:(NSString *)DBName{
    NSString *str = @"searchHistory.sqlite";
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:str];
    
    int status = sqlite3_open(fileName.UTF8String, &_db);
    if (status == SQLITE_OK) {
        
        NSString *sql = nil;
        
        sql = [NSString stringWithFormat:@"create table if not exists %@(title text not null)", DBName];
        
        char *errmeg = NULL;
        
        sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmeg);
        if (!errmeg) {
            [self.dataArray addObject:DBName];
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}

- (BOOL)deleteAllWithName:(NSString *)DBName {
    NSString *str = @"searchHistory.sqlite";
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:str];
    
    int status = sqlite3_open(fileName.UTF8String, &_db);
    if (status == SQLITE_OK) {
        
        NSString *sql = nil;
        
        sql = [NSString stringWithFormat:@"DELETE FROM %@", DBName];
        
        char *errmeg = NULL;
        
        sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmeg);
        if (!errmeg) {
            [self.dataArray addObject:DBName];
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
}

-(BOOL)insertData:(id)data inDataBase:(NSString *)name{
    if (self.dataArray) {
        NSString *sql = nil;
        
        sql = [NSString stringWithFormat:@"insert into %@(title) values('%@')", name, data];
        
        
        
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
        
    }else {
        return NO;
    }
    
}

-(BOOL)deleteData:(id)data inDataBase:(NSString*)name{
    if (self.dataArray) {
        NSString *sql = nil;
        
        sql = [NSString stringWithFormat:@"delete from %@ where title='%@'", name, data];
        
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
        
    }else {
        return NO;
    }
}

//查出数据库最后5条数据
-(NSMutableArray *)searchAllWithName:(NSString *)name{
    if (self.dataArray) {
        NSString *sql = nil;
        sql = [NSString stringWithFormat:@"select * from %@ order by rowid desc limit 5", name];

        if (sql) {
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            sqlite3_stmt *stmt = NULL;
            int status = sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL);
            if (status == SQLITE_OK) {
                while (sqlite3_step(stmt) == SQLITE_ROW) {
                    char *title = (char*)sqlite3_column_text(stmt, 0);
                    NSString *NSTitle = [NSString stringWithCString:title encoding:NSUTF8StringEncoding];
                    [arr addObject:NSTitle];
                }
                
                return arr;
            }else {
                return nil;
            }
            
        }else {
            return nil;
        }
        
    }else {
        return nil;
    }
}

-(BOOL)hasObject:(id)data inDataBase:(NSString *)name{
    if (self.dataArray) {
        
        NSString *sql = nil;
        
        sql = [NSString stringWithFormat:@"select * from %@ where title = '%@'", name, data];
        
        
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
        
    }else {
        return NO;
    }
}


@end
