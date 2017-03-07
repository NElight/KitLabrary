//
//  XmlResolve2.m
//  XML Fun
//
//  Created by mac os on 11-9-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "XmlResolve2.h"


@implementation XmlResolve2


@synthesize objName;
@synthesize tempString;
@synthesize namelist;
@synthesize valuelist;
@synthesize recordResuits;
@synthesize objectCount;
@synthesize returnObj;

- (void)dealloc
{
    [objName release];
    [tempString release];
    [namelist release];
    [valuelist release];
    [super dealloc];
}

-(NSMutableDictionary *)getObject:(NSString *)elName xmlData:(NSData *)xmlData
{
    returnObj = YES;
    NSMutableArray *list = [self getList:elName xmlData:xmlData];
    if ([list count]>0) {
        return [list objectAtIndex:0];
    }
    return nil;
}

-(NSMutableArray *)getList:(NSString *)elName xmlData:(NSData *)xmlData
{
    self.objName = elName;
    NSXMLParser *xmlRead = [[NSXMLParser alloc] initWithData:xmlData];
    
    self.namelist = [[[NSMutableArray alloc]init]autorelease];
    self.valuelist = [[[NSMutableArray alloc]init]autorelease];
    
    [xmlRead setDelegate:self];
    [xmlRead parse];
    [xmlRead release];
    
    if (objectCount>0) {
        int a = [namelist count];
        int b = (int)objectCount;
        int listSize = a/b;
        NSMutableArray *list = [[[NSMutableArray alloc]init]autorelease];
        NSMutableDictionary *map = [[[NSMutableDictionary alloc]init]autorelease];
        for (NSUInteger i=0;i<[namelist count];i++) {
            if (listSize == a/b) {
                map = [[[NSMutableDictionary alloc]init]autorelease];
                [list addObject:map];
            }
            [map setObject:[valuelist objectAtIndex:i] forKey:[namelist objectAtIndex:i]];
            listSize--;
            if (listSize==0) {
                listSize = a/b;
                if (returnObj)break;
            }
        }
        return list;
    }    
    return nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (recordResuits) {
        NSString *text = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (text==nil||[text isEqualToString:@""]||[text isEqualToString:@"\n"]) {
            self.tempString = nil;
        }else{
            self.tempString=text;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:objName]) {
        recordResuits = FALSE;
        objectCount++;
    }else{
        if (tempString!=nil) {
            [namelist addObject:elementName];
            [valuelist addObject:tempString];
            [tempString release];
            tempString = nil;
        }
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:objName]) {
        if (!tempString) {
            tempString = [[NSMutableString alloc]init];
        }
        recordResuits = TRUE;
    }    
}


@end
