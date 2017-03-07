//
//  XmlPackage.h
//  Xml Package
//
//  Created by mac os on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XmlNode.h"
@class XmlNode;

@interface XmlPackage : NSObject {
    
}
@property(nonatomic,retain)NSMutableDictionary *obj;
@property(nonatomic,retain)NSMutableString *xmlString;
@property BOOL isList;
@property(nonatomic,retain)NSString *objectName;
@property(nonatomic,retain)XmlNode *lvUp;
@property(nonatomic,retain)XmlNode *root;
@property BOOL buildEnd;

-(NSData *)objctPackage:(NSMutableDictionary *)object objectName:(NSString *)name xmlTemplateName:(NSString *)templateName;
-(NSData *)listPackage:(NSMutableArray *)objects objectName:(NSString *)name xmlTemplateName:(NSString *)templateName;

@end
