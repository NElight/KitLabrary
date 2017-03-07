//
//  Constant.h
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/3.
//
//

#ifndef Constant_h
#define Constant_h

typedef NS_ENUM(NSInteger, TeachPlanType) {
    TeachPlanTypeLesson = 0,
    TeachPlanTypeVideo,
    TeachPlanTypeTactical, //战术
    TeachPlanTypeTechnology
};

//占位图
#define PLACEHOLDER_IMAGE [UIImage imageNamed:@"user_head"]

//颜色
#define RGB(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

//宏定义
#pragma mark - System
//IOS版本
#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]

//系统名字  手机型号+系统+系统版本
#define SYSTEM_NAME  [NSString stringWithFormat:@"%@ %@ %@",[[UIDevice currentDevice] model],[[UIDevice currentDevice] systemName],[[UIDevice currentDevice] systemVersion]]

#define DEVICE_NAME  [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] model]]
// 应用版本
#define APPVERISON			[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//当前设备屏幕高度、宽度
#define DEVICE_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DEVICE_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//判断设备
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IPHONE_4 (fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480) < DBL_EPSILON)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_IPHONE_6_Plus ([UIScreen mainScreen].scale == 3 )
#define IS_IPHONE_6 (fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )

#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_STANDARD_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0  && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale == [UIScreen mainScreen].scale)
#define IS_ZOOMED_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale > [UIScreen mainScreen].scale)
#define IS_STANDARD_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_ZOOMED_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0 && IS_OS_8_OR_LATER && [UIScreen mainScreen].nativeScale < [UIScreen mainScreen].scale)



#define Scaled(a) ((int) ((a) * DEVICE_SCREEN_WIDTH / 375))

#define UIFont_Font(size) [UIFont systemFontOfSize:Scaled(size)]
#define UIFont_bold_Font(size) [UIFont boldSystemFontOfSize:size]
#define kNavBarHeight (SYSTEM_VERSION>=7?64:44)
#define kNavBarHeightLandscape (SYSTEM_VERSION>=7?52:32)


#define k1FontSize 16
#define k2FontSize 15
#define k3FontSize 14
#define k4FontSize 12
#define k5FontSize 11







//4.0 4.7 5.5尺寸放大系数
#define KSCALE ((IS_IPHONE_6)? 1.0:(DEVICE_SCREEN_WIDTH/375.))


#define wKSCALE ((IS_IPHONE_6_Plus)? 1.0:(DEVICE_SCREEN_WIDTH/414.))
#define hKSCALE ((IS_IPHONE_6_Plus)? 1.0:(DEVICE_SCREEN_HEIGHT/736.))


#define kScreenScale     [UIScreen mainScreen].scale
#define kwScaleBase6     (DEVICE_SCREEN_WIDTH / 375.0)



#define KSCALEWITHMARGIN(margin) ((IS_IPHONE_6 || IS_IPHONE_6_Plus)?((DEVICE_SCREEN_WIDTH - (margin))/(320. - (margin))):1.0)


#define KFOURSCALE ((IS_IPHONE_6 || IS_IPHONE_6_Plus||IS_IPHONE_5)?KSCALE:0.8)


//#define __WeakSelf__  __weak typeof (self)
//
//#define __WeakObject(object) __weak typeof (object)
//#define weakifyself __WeakSelf__ wSelf = self;
//#define strongifyself __StrongSelf__ self = wSelf;

//强弱引用。防止block不能释放
#define ZGWeakSelf(type)  __weak typeof(type) weak##type = type;
#define ZGStrongSelf(type)  __strong typeof(type) type = weak##type;

//定义圆角半径
#define Btn_CornerRadius 8

//数据库名称
#define LessonDBName @"LessonListModel"

#define VideoDBName @"VideoListModel"

#define TacticalDBName @"TacticalListModel"

#define LessonSearchHistoryDBName @"LessonSearchHistoryDB"
#define VideoSearchHistoryDBName @"VideoSearchHistoryDB"
#define TacticalSearchHistoryDBName @"TacticalSearchHistoryDB"
#define TechnologySearchHistoryDBName @"TechnologySearchHistoryDB"


#define NoticeType @"通知"
#define PolicyType @"政策法规"


#define printf_console printf
//#define NSLog(...) NSLog(__VA_ARGS__)//__PRETTY_FUNCTION__
#define FILE_NAME   [[[NSString stringWithFormat:@"%s", __FILE__] componentsSeparatedByString:@"/"] lastObject]

//开发环境下关闭log
#ifndef __OPTIMIZE__        // 开发环境下
#define NSLog(fmt, ...) {NSLog((@"%s [Line %d]\n[File: %@] " fmt), __PRETTY_FUNCTION__, __LINE__, FILE_NAME, ##__VA_ARGS__);}
#else                       // 生产环境下
#define NSLog(...) {}
#endif

#endif /* Constant_h */
