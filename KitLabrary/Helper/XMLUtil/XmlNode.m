//
//  XmlNode.m
//  Xml Package
//
//  Created by mac os on 11-10-12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "XmlNode.h"


@implementation XmlNode

@synthesize nodeName;
@synthesize nodeValue;
@synthesize isLast;
@synthesize list;
@synthesize xmlString;

- (void)dealloc
{
    [nodeName release];
    [nodeValue release];
    [list release];
    [xmlString release];
    [super dealloc];
}
-(NSString *)getXmlString
{
    xmlString = [[NSMutableString alloc]init];
    [xmlString appendString:@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"];
    [self getNodeStr:self string:xmlString];
    return xmlString;
}

-(void)getNodeStr:(XmlNode *)node string:(NSMutableString *)str
{
    if (node.isLast) {
        NSString *res = [[NSString alloc]initWithFormat:@"<%@>%@</%@>",
          node.nodeName,
          node.nodeValue,
          node.nodeName];
        [str appendString:res];
        [res release];
    }else{
        NSMutableString *a = [[[NSMutableString alloc]init]autorelease];
        NSMutableArray *nodelist = [node getChilds];
        for (int i=0;i<[nodelist count];i++) {
            XmlNode *node = [nodelist objectAtIndex:i];
            [node getNodeStr:node string:a];
        }
        NSString *res = [[NSString alloc]initWithFormat:@"<%@>%@</%@>",
                         node.nodeName,
                         a,
                         node.nodeName];
        [str appendString:res];
        [res release];
    }
}

-(void)addChildNode:(XmlNode *)node;
{
    if (list==nil) {
        list = [[NSMutableArray alloc]init];
    }
    [list addObject:node];
    isLast = NO;
}

-(NSMutableArray *)getChilds
{
    return list;
}

-(void)addChildByMap:(NSMutableDictionary *)map
{
    NSEnumerator *keys = [map keyEnumerator];
    id key;
    while (key = [keys nextObject]) {
        XmlNode *node = [[[XmlNode alloc]init]autorelease];
        node.isLast = YES;
        node.nodeName = key;
        node.nodeValue = [map objectForKey:key];
        [self addChildNode:node];
    }
}

@end
