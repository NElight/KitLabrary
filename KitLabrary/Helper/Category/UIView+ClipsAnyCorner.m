//
//  UIView+ClipsAnyCorner.m
//  YioksFootball-Test
//
//  Created by Yioks-Mac on 16/8/20.
//  Copyright © 2016年 PingXuhui. All rights reserved.
//

#import "UIView+ClipsAnyCorner.h"

@implementation UIView (ClipsAnyCorner)

#pragma mark - 切任意圆角
- (void)clipCorner:(UILabel *)lab rectCorner:(UIRectCorner)rectCorner size:(CGSize)size{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:lab.bounds byRoundingCorners:rectCorner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = lab.bounds;
    maskLayer.path = maskPath.CGPath;
    lab.layer.mask = maskLayer;
}

- (void)clipCornerWithRectCorner:(UIRectCorner)rectCorner size:(CGSize)size {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
