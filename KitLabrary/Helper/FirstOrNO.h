//
//  FirstOrNO.h
//  FirstApp
//
//  Created by Yioks-Mac on 16/7/28.
//

#import <Foundation/Foundation.h>



@interface FirstOrNO : NSObject
/**
 *  记录用户打开应用的次数
 */
+(void)recordUserOpenAppTimes;
/**
 *  是否是第一次打开应用
 *
 */
+(BOOL)isFirstOpen;
/**
 *  返回用户打开应用的次数
 *
 *  @return 打开应用的次数
 */
+(NSInteger)openAppTimes;
@end
