//
//  DeviceManager.m
//  Unity-iPhone
//
//  Created by Mac on 16/8/5.
//
//

#import "DeviceManager.h"

@implementation DeviceManager

+ (NSString *)getUUIDString {
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"*******" accessGroup:nil];
    NSString *UUIDString = [wrapper objectForKey:(__bridge id)kSecValueData];
    if (UUIDString.length == 0) {
        UUIDString = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [wrapper setObject:UUIDString forKey:(__bridge id)kSecValueData];
    }
    return UUIDString;
}

@end
