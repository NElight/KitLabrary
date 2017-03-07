//
//  CALayer+LayerColor.m
//  UnityFootball
//
//  Created by PingXuhui on 16/11/12.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "CALayer+LayerColor.h"

@implementation CALayer (LayerColor)

- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

@end
