//
//  UIImageView+CircleImageView.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/11/24.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "UIImageView+CircleImageView.h"
#import "UIImage+CircleImage.h"

@implementation UIImageView (CircleImageView)

- (void)setCircleImage:(NSString *)imageUrl withPlaceholderImage:(NSString *)placeholderImageName
{
    UIImage * placeholderImage = [UIImage imageNamed:placeholderImageName];
    [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage]:[placeholderImage circleImage];
    }];
}

@end
