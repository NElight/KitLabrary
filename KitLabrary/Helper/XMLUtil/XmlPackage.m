//
//  XmlPackage.m
//  Xml Package
//
//  Created by mac os on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "XmlPackage.h"
#import <CoreData/CoreData.h>
#import "XmlNode.h"


@implementation XmlPackage

@synthesize obj;
@synthesize isList;
@synthesize xmlString;
@synthesize objectName;
@synthesize lvUp;
@synthesize root;
@synthesize buildEnd;

-(NSData *)objctPackage:(NSMutableDictionary *)object objectName:(NSString *)name xmlTemplateName:(NSString *)templateName
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:object];
    NSData *data = [self listPackage:array objectName:name xmlTemplateName:templateName];
    [array release];
    return data;
}

-(NSData *)listPackage:(NSMutableArray *)objects objectName:(NSString *)name xmlTemplateName:(NSString *)templateName
{
    isList = YES;
    self.objectName = name;
    NSString *path = [[NSBundle mainBundle] pathForResource:templateName ofType:@"xml"];
    NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *xmlData = [file readDataToEndOfFile];
    NSXMLParser *xmlRead = [[NSXMLParser alloc] initWithData:xmlData];
    [xmlRead setDelegate:self];
    [xmlRead parse];
    [xmlRead release];
    //get dataTemplate
    for (int i=0;i<[objects count]; i++) {
        NSMutableDictionary *map = [objects objectAtIndex:i];
        XmlNode *node = [[[XmlNode alloc]init]autorelease];
        node.nodeName = objectName;
        [node addChildByMap:map];
        [lvUp addChildNode:node];
    }
    //get root's xmlString
    NSMutableString *x = [self.root getXmlString];
    //NSLog(@"%@",x);
    if ((int)[x length]>0) {
        return [x dataUsingEncoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (void)dealloc
{
    [obj release];
    [xmlString release];
    [objectName release];
    [lvUp release];
    //[root release];
    [super dealloc];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{

}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{   
    if ([elementName isEqualToString:objectName]) {   
        buildEnd = YES;
    }else{
        if (!buildEnd) {
            //create node
            XmlNode *node = [[XmlNode alloc]init];
            node.nodeName = elementName;
            //dataTemplate building...
            if (lvUp!=nil) {
                [lvUp addChildNode:node];
            }else{
                root = node;
            }
            lvUp = node;
        }
    }
}


@end
