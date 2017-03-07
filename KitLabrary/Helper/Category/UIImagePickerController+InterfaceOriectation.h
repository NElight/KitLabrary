//
//  UIImagePickerController+InterfaceOriectation.h
//  UnityFootball
//
//  Created by PingXuhui on 16/11/14.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (InterfaceOriectation)

- (BOOL)shouldAutorotate;

- (UIInterfaceOrientationMask)supportedInterfaceOrientations;

@end
