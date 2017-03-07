//
//  ReverseTypeName.h
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/11.
//
//

#import <Foundation/Foundation.h>

@interface ReverseTypeName : NSObject

//根据类型得到名称
+ (NSString*)reverseTypeToName:(TeachPlanType)type;

//根据类型得到搜索页面的名称
+ (NSString *)reverseTypeToSearchVCName:(TeachPlanType)type;

@end
