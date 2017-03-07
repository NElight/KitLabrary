//
//  ZGXMLUtil.h
//  UnityFootball
//
//  Created by Yioks-Mac on 16/12/6.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "FightModel.h"

@interface ZGXMLUtil : NSObject

+ (FightModel *)fightFromXMLData:(NSData *)xmlData;

+ (GDataXMLDocument *)xmlDocFromFightModel:(FightModel *)fight withFileName:(NSString *)fileName;

@end
