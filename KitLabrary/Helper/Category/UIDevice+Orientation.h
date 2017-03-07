//
//  UIDevice+Orientation.h
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/8.
//
//

#import <UIKit/UIKit.h>

@interface UIDevice (Orientation)

/**
 *  强制旋转设备
 *  @param  旋转方向
 */
+ (void)setOrientation:(UIInterfaceOrientation)orientation;

@end
