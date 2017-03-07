//
//  SearchHistoryManager.h
//  UnityFootball
//
//  Created by Yioks-Mac on 16/10/26.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchHistoryManager : NSObject

+(instancetype)sharedManager;

-(BOOL)createDataBaseWithName:(NSString*)DBName;

-(BOOL)insertData:(id)data inDataBase:(NSString *)name;

-(BOOL)deleteData:(id)data inDataBase:(NSString *)name;

-(NSMutableArray *)searchAllWithName:(NSString *)name;

-(BOOL)hasObject:(id)data inDataBase:(NSString *)name;

- (BOOL)deleteAllWithName:(NSString *)DBName;

@end
