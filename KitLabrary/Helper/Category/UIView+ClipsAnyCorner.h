//
//  UIView+ClipsAnyCorner.h
//  YioksFootball-Test
//
//  Created by Yioks-Mac on 16/8/20.
//  Copyright © 2016年 PingXuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ClipsAnyCorner)

- (void)clipCorner:(UILabel *)lab rectCorner:(UIRectCorner)rectCorner size:(CGSize)size;

- (void)clipCornerWithRectCorner:(UIRectCorner)rectCorner size:(CGSize)size;

@end
