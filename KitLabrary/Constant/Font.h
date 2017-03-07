//
//  Font.h
//  UnityFootball
//
//  Created by Yioks-Mac on 17/2/22.
//  Copyright © 2017年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ZGFontStyle) {
    ZGFontStyle1,
    ZGFontStyle2,
    ZGFontStyle3,
    ZGFontStyle4,
    ZGFontStyle5,
};

@interface Font : NSObject

+ (UIFont *)zg_fontWithStyle:(ZGFontStyle)style;


@end
