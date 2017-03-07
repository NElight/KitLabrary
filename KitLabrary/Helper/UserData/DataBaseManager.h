//
//  DataBaseManager.h
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/11.
//
//

#import <Foundation/Foundation.h>

@interface DataBaseManager : NSObject

+(instancetype)sharedManager;

-(BOOL)createDataBaseWithName:(NSString*)DBName;

-(BOOL)insertData:(id)data;

-(BOOL)deleteData:(id)data;

-(NSMutableArray *)searchAllWithName:(NSString *)name;

-(BOOL)hasObject:(id)data;

@end
