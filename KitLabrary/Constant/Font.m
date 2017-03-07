//
//  Font.m
//  UnityFootball
//
//  Created by Yioks-Mac on 17/2/22.
//  Copyright © 2017年 Yioks. All rights reserved.
//

#import "Font.h"

@implementation Font

+ (UIFont *)zg_fontWithStyle:(ZGFontStyle)style {
    switch (style) {
        case ZGFontStyle1:
            return [UIFont systemFontOfSize:15];
            break;
        case ZGFontStyle2:
            return [UIFont systemFontOfSize:15];
            break;
        case ZGFontStyle3:
            return [UIFont systemFontOfSize:15];
            break;
        case ZGFontStyle4:
            return [UIFont systemFontOfSize:15];
            break;
        case ZGFontStyle5:
            return [UIFont systemFontOfSize:15];
            break;
            
        default:
            return [UIFont systemFontOfSize:12];
            break;
    }
}



//CGFloat k1FontSize = 16;
//CGFloat k2FontSize = 15;
//CGFloat k3FontSize = 14;
//CGFloat k4FontSize = 12;
//CGFloat k5FontSize = 11;

@end
