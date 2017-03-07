//
//  Color.h
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/2.
//
//

#import <Foundation/Foundation.h>



//区间线：#f0f0f0
//常规背景：f0f0f0
//头部滑块：#f2f2f2
//主色绿：#259b24
//主色黄：#ffa726
//主色橙：#ff5722
//主色红：#e51c23
//主色轻灰：#ababab
//主色重灰：#4f4f4f
//主色黑：#101010

@interface Color : NSObject

UIKIT_EXTERN NSString *yioks_0x_white_bg;

UIKIT_EXTERN NSString *yioks_0x_white_headerSlider;

UIKIT_EXTERN NSString *yioks_0x_green_main;

UIKIT_EXTERN NSString *yioks_0x_yellow_main;

UIKIT_EXTERN NSString *yioks_0x_orange_main;

UIKIT_EXTERN NSString *yioks_0x_red_main;

UIKIT_EXTERN NSString *yioks_0x_lightgray;

UIKIT_EXTERN NSString *yioks_0x_darkgray;

UIKIT_EXTERN NSString *yioks_0x_black_main;

UIKIT_EXTERN NSString *yioks_0x_orange2_main;

UIKIT_EXTERN NSString *yioks_0x_button_default_green;

UIKIT_EXTERN NSString *yioks_0x_green_important;//页面顶部菜单栏，选中标签文字的颜色
UIKIT_EXTERN NSString *yioks_0x_lightgreen_important;//重要的按钮，控件，标题，正文文字的颜色
UIKIT_EXTERN NSString *yioks_0x_dark_important;//重要突出的列表名称颜色，弹框文字颜色，正文文字颜色
UIKIT_EXTERN NSString *yioks_0x_lightdark_important;//重要的标题，菜单栏文字，内容文字的颜色
UIKIT_EXTERN NSString *yioks_0x_green_normal;//一般的图标，控件，按钮，文字的颜色
UIKIT_EXTERN NSString *yioks_0x_darkgray_normal;//一般的图标，分割线，文字的颜色
UIKIT_EXTERN NSString *yioks_0x_gray_normal;//一般的正文文字颜色，小图标文字颜色
UIKIT_EXTERN NSString *yioks_0x_lightgray_normal;//辅助说明文字的颜色，按钮，标签边缘
UIKIT_EXTERN NSString *yioks_0x_lightgray_weak;//用于分隔模块的底色

UIKIT_EXTERN NSString *yioks_0x_oneballcolor;
UIKIT_EXTERN NSString *yioks_0x_twoballcolor;//下拉刷新的两个小球颜色



@end
