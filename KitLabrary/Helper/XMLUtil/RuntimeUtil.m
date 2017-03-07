//
//  RuntimeUtil.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/12/7.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "RuntimeUtil.h"
#import "GDataXMLNode.h"
#import <objc/runtime.h>


@implementation RuntimeUtil

const char *kPropertyListKey = "ZGPropertyListKey";
+ (NSArray *)zg_objcProperties:(Class)c
{
    /* 获取关联对象 */
    NSArray *ptyList = objc_getAssociatedObject(c, kPropertyListKey);
    /* 如果 ptyList 有值,直接返回 */
    if (ptyList) {
        return ptyList;
    }
    /* 调用运行时方法, 取得类的属性列表 */
    /* 成员变量:
     * class_copyIvarList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 方法:
     * class_copyMethodList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 属性:
     * class_copyPropertyList(__unsafe_unretained Class cls, unsigned int *outCount)
     * 协议:
     * class_copyProtocolList(__unsafe_unretained Class cls, unsigned int *outCount)
     */
    unsigned int outCount = 0;
    /**
     * 参数1: 要获取得类
     * 参数2: 雷属性的个数指针
     * 返回值: 所有属性的数组, C 语言中,数组的名字,就是指向第一个元素的地址
     */
    /* retain, creat, copy 需要release */
    objc_property_t *propertyList = class_copyPropertyList(c, &outCount);
    NSMutableArray *mtArray = [NSMutableArray array];
    /* 遍历所有属性 */
    for (unsigned int i = 0; i < outCount; i++) {
        /* 从数组中取得属性 */
        objc_property_t property = propertyList[i];
        /* 从 property 中获得属性名称 */
        const char *propertyName_C = property_getName(property);
        /* 将 C 字符串转化成 OC 字符串 */
        NSString *propertyName_OC = [NSString stringWithCString:propertyName_C encoding:NSUTF8StringEncoding];
        [mtArray addObject:propertyName_OC];
    }
    /* 设置关联对象 */
    /**
     *  参数1 : 对象self
     *  参数2 : 动态添加属性的 key
     *  参数3 : 动态添加属性值
     *  参数4 : 对象的引用关系
     */
    objc_setAssociatedObject(c, kPropertyListKey, mtArray.copy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    /* 释放 */
    free(propertyList);
    return mtArray.copy;
}

+ (FightModel *)fightFromXmlData:(NSData *)xmlData {
    NSError *err = nil;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithData:xmlData options:0 error:&err];
    GDataXMLElement *rootElement = [doc rootElement];
    //    Class c = objc_getRequiredClass("FightModel");
    id objc = [self parseXmlNode:rootElement className:@"FightModel"];
    return objc;
}

+ (id)parseXmlNode:(GDataXMLElement *)element className:(NSString *)className {
    Class c = objc_getClass([className cStringUsingEncoding:NSUTF8StringEncoding]);
    if (!c) {
        return nil;
    }
    //    Class c = objc_getRequiredClass([className cStringUsingEncoding:NSUTF8StringEncoding]);
    if ([className isEqualToString:@"FightModel"]) {
        className = @"opt";
    }
    id objc = [[c alloc]init];
    NSArray *propertyList = [self zg_objcProperties:c];
    for (NSString *property in propertyList) {
        NSArray *temp = [element elementsForName:property];
        const char *attr = property_getAttributes(class_getProperty(c, [property cStringUsingEncoding:NSUTF8StringEncoding]));
        NSString *typeStr = [NSString stringWithFormat:@"%s", attr];
        NSArray *attriArr = [typeStr componentsSeparatedByString:@","];
        NSString *type = attriArr[0];
        NSString * propertyType = [type substringFromIndex:1];
        const char * rawPropertyType = [propertyType UTF8String];
        unsigned int attrCount = 0;
        objc_property_attribute_t *attrs = property_copyAttributeList(class_getProperty(c, [property cStringUsingEncoding:NSUTF8StringEncoding]), &attrCount);
        objc_property_attribute_t attr1 = attrs[0];
        const char *pattr = attr1.value;
        
        if (temp.count == 0) {
            continue;
        }else if (temp.count == 1 && strcmp(rawPropertyType, "@\"NSString\"") == 0) {
            [objc setValue:[[temp objectAtIndex:0] stringValue] forKey:property];
        }else {
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
            for (GDataXMLElement *node in temp) {
                id child = [self parseXmlNode:node className:property];
                if (child) {
                    [arr addObject:child];
                }
            }
            [objc setValue:arr forKey:property];
        }
    }
    
    return objc;
    
}

@end
