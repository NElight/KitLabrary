//
//  NSArray+UrlParameter.m
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/10.
//
//

#import "NSArray+UrlParameter.h"

@implementation NSArray (UrlParameter)

-(NSString *)toUrlParameter {
    return [self componentsJoinedByString:@","];
}

@end
