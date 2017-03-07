//
//  UIDevice+UserInfo.m
//  Unity-iPhone
//
//  Created by Yioks-Mac on 16/8/9.
//
//

#import "UIDevice+UserInfo.h"

@implementation UIDevice (UserInfo)

+(NSString *)getDeviceDesciption{
    UIDevice *device = [UIDevice currentDevice];
    NSString *name = device.name;
    NSString *model = device.model;
    NSString *localizeModel = device.localizedModel;
    NSString *systemName = device.systemName;
    NSString *systemVersion = device.systemVersion;
    return [NSString stringWithFormat:@"name:%@, device:%@%@, system:%@%@", name, model, localizeModel, systemName, systemVersion];
}

@end
