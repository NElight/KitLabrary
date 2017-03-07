//
//  UIAlertController+SupportedInterface.h
//  UnityFootball
//
//  Created by PingXuhui on 16/11/14.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (SupportedInterface)

- (BOOL)shouldAutorotate;

- (UIInterfaceOrientationMask)supportedInterfaceOrientations;


@end
