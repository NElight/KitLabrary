//
//  NSMutableAttributedString+AddImage.h
//  YioksFootball-Test
//
//  Created by Yioks-Mac on 16/8/18.
//  Copyright © 2016年 PingXuhui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (AddImage)

- (instancetype)addImageWithName:(NSString*)imageName frame:(CGRect)frame;

- (instancetype)addImage:(UIImage*)image frame:(CGRect)frame;


/**
 图文富文本

 @param imageName 图片名
 @param frame 图片frame
 @param string 文字
 @return 返回一个 attributText
 */
- (NSMutableAttributedString *)attributedAddImageName:(NSString *)imageName withFrame:(CGRect)frame withString:(NSString *)string;

- (NSMutableAttributedString *)attributedAddImage:(UIImage *)image withFrame:(CGRect)frame withString:(NSString *)string;

- (instancetype)changeColorWithColor:(UIColor *)color totalString:(NSString *)totalString subStringArray:(NSArray *)subArray;

@end
