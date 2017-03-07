//
//  XmlNode.h
//  Xml Package
//
//  Created by mac os on 11-10-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XmlNode : NSObject {
    
}
@property(nonatomic,retain)NSString *nodeName;
@property(nonatomic,retain)NSString *nodeValue;
@property BOOL isLast;
@property(nonatomic,retain)NSMutableArray *list;
@property(nonatomic,retain)NSMutableString *xmlString;

-(void)addChildNode:(XmlNode *)node;
-(NSMutableArray *)getChilds;
-(void)addChildByMap:(NSMutableDictionary *)map;
-(void)getNodeStr:(XmlNode *)node string:(NSMutableString *)str;

-(NSMutableString *)getXmlString;

@end
