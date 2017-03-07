//
//  MatchDB.h
//  UnityFootball
//
//  Created by Yioks-Mac on 16/12/13.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FightStateModel.h"

@interface MatchDB : NSObject

+ (instancetype) sharedManager;

- (BOOL)createTableWithName:(NSString *)tableName;

- (BOOL)hasMatchWithToken:(NSString *)token;

- (BOOL)insertMatch:(FightStateModel *)model;

- (BOOL)deleteMatch:(NSString *)token;

- (FightStateModel *)searchMatchFromToken:(NSString *)token;

- (BOOL)updateMatch:(FightStateModel *)model;

@end
