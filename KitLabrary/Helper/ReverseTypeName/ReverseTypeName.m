//
//  ReverseTypeName.m
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/11.
//
//

#import "ReverseTypeName.h"

@implementation ReverseTypeName

+ (NSString*)reverseTypeToName:(TeachPlanType)type{
    if (type == TeachPlanTypeLesson) {
        return @"课堂教案";
    }else if (type == TeachPlanTypeVideo) {
        return @"视频库";
    }else if (type == TeachPlanTypeTactical) {
        return @"战术资源";
    }else if (type == TeachPlanTypeTechnology){
        return @"技术资源";
    }
    else {
        return nil;
    }
}

+ (NSString *)reverseTypeToSearchVCName:(TeachPlanType)type{
    if (type == TeachPlanTypeLesson) {
        return @"课堂教案搜索";
    }else if (type == TeachPlanTypeVideo) {
        return @"视频教案搜索";
    }else if (type == TeachPlanTypeTactical) {
        return @"战术教案搜索";
    }else if (type == TeachPlanTypeTechnology) {
        return @"技术教案搜索";
    }else {
        return nil;
    }
}

@end
