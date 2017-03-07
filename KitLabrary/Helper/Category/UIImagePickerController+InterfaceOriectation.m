//
//  UIImagePickerController+InterfaceOriectation.m
//  UnityFootball
//
//  Created by PingXuhui on 16/11/14.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "UIImagePickerController+InterfaceOriectation.h"

@implementation UIImagePickerController (InterfaceOriectation)

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
