//
//  DataBaseManager.m
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/11.
//
//

#import "DataBaseManager.h"
#import <sqlite3.h>

#import "LessonListModel.h"
#import "VideoListModel.h"
#import "TacticalListModel.h"

@interface DataBaseManager (){
    sqlite3 *_db;
}

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DataBaseManager

+(instancetype)sharedManager{
    static DataBaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataBaseManager alloc]init];
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
    NSString *str = @"collection.sqlite";
    NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:str];
    
    int status = sqlite3_open(fileName.UTF8String, &_db);
    if (status == SQLITE_OK) {
        
        NSString *sql = nil;
        
        if ([DBName isEqualToString:LessonDBName]) {
            sql = [NSString stringWithFormat:@"create table if not exists %@(id text not null,title text not null,chapter text,semester text,press text,img text)", DBName];
        }else if ([DBName isEqualToString:VideoDBName]) {
            sql = [NSString stringWithFormat:@"create table if not exists %@(id text not null,title text not null,category text,author text,level text,img text)", DBName];
        }else if ([DBName isEqualToString:TacticalDBName]){
            sql = [NSString stringWithFormat:@"create table if not exists %@(id text not null,title text not null,category text,author text,level text,img text)", DBName];
        }
        
        
        
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

-(BOOL)insertData:(id)data{
    if (self.dataArray) {
        NSString *sql = nil;
        if ([data isKindOfClass:[LessonListModel class]]) {
            sql = [NSString stringWithFormat:@"insert into LessonListModel(id,title,chapter,semester,press,img) values ('%@','%@','%@','%@','%@','%@')", [data ID], [data title], [data chapter], [data semester], [data press], [data image]];
        }else if ([data isKindOfClass:[VideoListModel class]]){
            sql = [NSString stringWithFormat:@"insert into VideoListModel(id,title,category,author,level,img) values('%@','%@','%@','%@','%@','%@')", [data ID], [data videoName], [data videoTypeName], [data videoAuthor], [data videoLevelName], [data videoImage]];
        }else if ([data isKindOfClass:[TacticalListModel class]]){
            sql = [NSString stringWithFormat:@"insert into TacticalListModel(id,title,category,author,level,img) values('%@','%@','%@','%@','%@','%@')", [data ID], [data tacticalName], [data tacticalTypeName], [data tacticalAuthor], [data tacticalLevelName], [data tacticalImage]];
        }else if ([data isKindOfClass:[NSString class]]) {
            sql = [NSString stringWithFormat:@"insert into SearchHistoryDB(title) values('%@')", data];
        }
        
        
        
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

-(BOOL)deleteData:(id)data{
    if (self.dataArray) {
        NSString *sql = nil;
        if ([data isKindOfClass:[LessonListModel class]]) {
            sql = [NSString stringWithFormat:@"delete from LessonListModel where title='%@'", [data title]];
        }else if ([data isKindOfClass:[VideoListModel class]]){
            sql = [NSString stringWithFormat:@"delete from VideoListModel where title='%@'", [data videoName]];
        }else if ([data isKindOfClass:[TacticalListModel class]]) {
            sql = [NSString stringWithFormat:@"delete from TacticalListModel where title='%@'", [data tacticalName]];
        }else if ([data isKindOfClass:[NSString class]]) {
            sql = [NSString stringWithFormat:@"delete from SearchHistoryDB where title='%@'", data];
        }
        
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

-(NSMutableArray *)searchAllWithName:(NSString *)name{
    if (self.dataArray) {
        NSString *sql = nil;
        if ([name isEqualToString:NSStringFromClass([LessonListModel class])]) {
            sql = [NSString stringWithFormat:@"select * from LessonListModel"];
        }else if ([name isEqualToString:NSStringFromClass([VideoListModel class])]){
            sql = [NSString stringWithFormat:@"select * from VideoListModel"];
        }else if ([name isEqualToString:NSStringFromClass([TacticalListModel class])]) {
            sql = [NSString stringWithFormat:@"select * from TacticalListModel"];
        }
        
        if (sql) {
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            sqlite3_stmt *stmt = NULL;
            int status = sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, NULL);
            if (status == SQLITE_OK) {
                while (sqlite3_step(stmt) == SQLITE_ROW) {
                    char *dataId = (char*)sqlite3_column_text(stmt, 0);
                    char *title = (char*)sqlite3_column_text(stmt, 1);
                    char *chapter = (char *)sqlite3_column_text(stmt, 2);
                    char *semester = (char *)sqlite3_column_text(stmt, 3);
                    char *press = (char *)sqlite3_column_text(stmt, 4);
                    char *img = (char *)sqlite3_column_text(stmt, 5);
                    
                    if ([name isEqualToString:NSStringFromClass([LessonListModel class])]) {
                        
                        LessonListModel *model = [[LessonListModel alloc]init];
                        model.ID = [NSString stringWithUTF8String:dataId];
                        model.title = [NSString stringWithUTF8String:title];
                        model.chapter = [NSString stringWithUTF8String:chapter];
                        model.semester = [NSString stringWithUTF8String:semester];
                        model.press = [NSString stringWithUTF8String:press];
                        model.image = [NSString stringWithUTF8String:img];
                        [arr addObject:model];
                        
                    }else if ([name isEqualToString:NSStringFromClass([VideoListModel class])]){
                        
                        VideoListModel *model = [[VideoListModel alloc]init];
                        model.ID = [NSString stringWithUTF8String:dataId];
                        model.videoName = [NSString stringWithUTF8String:title];
                        model.videoTypeName = [NSString stringWithUTF8String:chapter];
                        model.videoAuthor = [NSString stringWithUTF8String:semester];
                        model.videoLevelName = [NSString stringWithUTF8String:press];
                        model.videoImage = [NSString stringWithUTF8String:img];
                        [arr addObject:model];
                        
                    }else if ([name isEqualToString:NSStringFromClass([TacticalListModel class])]) {
                        
                        TacticalListModel *model = [[TacticalListModel alloc]init];
                        model.ID = [NSString stringWithUTF8String:dataId];
                        model.tacticalName = [NSString stringWithUTF8String:title];
                        model.tacticalTypeName = [NSString stringWithUTF8String:chapter];
                        model.tacticalAuthor = [NSString stringWithUTF8String:semester];
                        model.tacticalLevelName = [NSString stringWithUTF8String:press];
                        model.tacticalImage = [NSString stringWithUTF8String:img];
                        [arr addObject:model];
                    }
                    
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

-(BOOL)hasObject:(id)data{
    if (self.dataArray) {
        
        NSString *sql = nil;
        if ([data isKindOfClass:[LessonListModel class]]) {
            sql = [NSString stringWithFormat:@"select * from LessonListModel where title='%@'", [data title]];
        }else if ([data isKindOfClass:[VideoListModel class]]){
            sql = [NSString stringWithFormat:@"select * from VideoListModel where title='%@'", [data videoName]];
        }else if ([data isKindOfClass:[TacticalListModel class]]) {
            sql = [NSString stringWithFormat:@"select * from TacticalListModel where title = '%@'", [data tacticalName]];
        }
        
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
