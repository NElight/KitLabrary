
//
//  UIDevice+Orientation.m
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/8.
//
//

#import "UIDevice+Orientation.h"

@implementation UIDevice (Orientation)

//调用私有方法实现
+ (void)setOrientation:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[self currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}

@end
