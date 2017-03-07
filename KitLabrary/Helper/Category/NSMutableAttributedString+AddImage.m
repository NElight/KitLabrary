//
//  NSMutableAttributedString+AddImage.m
//  YioksFootball-Test
//
//  Created by Yioks-Mac on 16/8/18.
//  Copyright © 2016年 PingXuhui. All rights reserved.
//

#import "NSMutableAttributedString+AddImage.h"

@implementation NSMutableAttributedString (AddImage)

- (instancetype)addImageWithName:(NSString*)imageName frame:(CGRect)frame{
    
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:imageName];
    // 设置图片大小
    attch.bounds = frame;
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [self appendAttributedString:string];
    return self;
    
}

- (instancetype)addImage:(UIImage*)image frame:(CGRect)frame{
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = image;
    // 设置图片大小
    attch.bounds = frame;
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [self appendAttributedString:string];
    return self;
}

- (NSMutableAttributedString *)attributedAddImageName:(NSString *)name withFrame:(CGRect)frame withString:(NSString *)string {
//    NSMutableAttributedString *nameAttri = [[NSMutableAttributedString alloc]init];
    [self addImageWithName:name frame:frame];
    NSAttributedString *nameCategory = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@", string]];
    [self appendAttributedString:nameCategory];
    return self;
}

- (NSMutableAttributedString *)attributedAddImage:(UIImage *)image withFrame:(CGRect)frame withString:(NSString *)string{
    [self addImage:image frame:frame];
    NSAttributedString *nameCategory = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@", string]];
    [self appendAttributedString:nameCategory];
    return self;
}

- (instancetype)changeColorWithColor:(UIColor *)color totalString:(NSString *)totalString subStringArray:(NSArray *)subArray {
    
    for (NSString *rangStr in subArray) {
        NSRange range = [totalString rangeOfString:rangStr options:NSBackwardsSearch];
        [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return self;
}

@end
