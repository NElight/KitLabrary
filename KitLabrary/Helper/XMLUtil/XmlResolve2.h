//
//  XmlResolve2.h
//  XML Fun
//
//  Created by mac os on 11-9-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XmlResolve2 : NSObject {
    
}
@property (nonatomic, retain) NSString *objName;
@property (nonatomic, retain) NSString *tempString;
@property (nonatomic, retain) NSMutableArray *namelist;
@property (nonatomic, retain) NSMutableArray *valuelist;
@property BOOL recordResuits;
@property int objectCount;
@property BOOL returnObj;

-(NSMutableDictionary *)getObject:(NSString *)elName xmlData:(NSData *)xmlData;
-(NSMutableArray *)getList:(NSString *)elName xmlData:(NSData *)xmlData;

@end
