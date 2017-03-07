//
//  XMLUtil.h
//  UnityFootball
//
//  Created by Yioks-Mac on 16/11/9.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "Fight.h"

@interface XMLUtil : NSObject

//NSString *getFightFilePath();


@property (nonatomic, strong) Fight *fight;

- (instancetype)initWithData:(NSData *)data;

- (void)startParse;

+ (GDataXMLDocument *)xmlFromFight:(Fight *)fight;

@end
