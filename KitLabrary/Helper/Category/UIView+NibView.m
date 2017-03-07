//
//  UIView+NibView.m
//  YioksFootball-Net
//
//  Created by Yioks-Mac on 16/9/14.
//  Copyright © 2016年 Yioks-Mac. All rights reserved.
//

#import "UIView+NibView.h"

@implementation UIView (NibView)

+ (instancetype)viewFromNibWithName:(NSString *)str{
    UINib *nib = [UINib nibWithNibName:str bundle:nil];
    NSArray *arr = [nib instantiateWithOwner:self options:nil];
    return arr[0];
}

@end
