//
//  UIView+NibView.h
//  YioksFootball-Net
//
//  Created by Yioks-Mac on 16/9/14.
//  Copyright © 2016年 Yioks-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NibView)

+ (instancetype)viewFromNibWithName:(NSString *)str;

@end
