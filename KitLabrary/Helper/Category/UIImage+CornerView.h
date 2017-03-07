//
//  UIImage+CornerView.h
//  模块封装
//
//  Created by Yioks-Mac on 16/8/1.
//  Copyright © 2016年 Yioks-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CornerView)

- (void)oa_cornerImageWithSize:(CGSize)size fillColor: (UIColor *)fillColor
                    completion:(void (^)(UIImage *))completion;

@end
