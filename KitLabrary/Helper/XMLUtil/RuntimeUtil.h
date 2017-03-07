//
//  RuntimeUtil.h
//  UnityFootball
//
//  Created by Yioks-Mac on 16/12/7.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuntimeUtil : NSObject

+ (NSArray *)zg_objcProperties:(Class)c;

+ (FightModel *)fightFromXmlData:(NSData *)xmlData;

@end
