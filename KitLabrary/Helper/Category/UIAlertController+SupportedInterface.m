//
//  UIAlertController+SupportedInterface.m
//  UnityFootball
//
//  Created by PingXuhui on 16/11/14.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "UIAlertController+SupportedInterface.h"

@implementation UIAlertController (SupportedInterface)

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
