//
//  SinaUtil.m
//  UnityFootball
//
//  Created by Yioks-Mac on 17/1/19.
//  Copyright © 2017年 Yioks. All rights reserved.
//

#import "SinaUtil.h"


#define kSinaAppKey @"3399839963"

@implementation SinaUtil

+ (instancetype)sharedManager {
    static SinaUtil *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [WeiboSDK enableDebugMode:YES];
        [WeiboSDK registerApp:kSinaAppKey];
    }
    return self;
}

- (void)shareSinaWeiboWithText:(NSString *)text{
    if ([WeiboSDK isWeiboAppInstalled]) {
        WBMessageObject *message = [WBMessageObject message];
        message.text = text;
        WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:req];
    }else {
        NSLog(@"");
    }
}

- (void)shareSinaWeiboWithText:(NSString *)text withImage:(UIImage *)image{
    if ([WeiboSDK isWeiboAppInstalled]) {
        WBMessageObject *message = [WBMessageObject message];
        message.text = text;
        
        WBImageObject *imageObj = [WBImageObject object];
        imageObj.imageData = UIImagePNGRepresentation(image);
        message.imageObject = imageObj;
        
        WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:req];
    }else {
        NSLog(@"");
    }
}

- (void)shareSinaWeiboWithText:(NSString *)text title:(NSString *)title description:(NSString *)description thumbImage:(UIImage *)image withUrlStr:(NSString *)urlStr {
    if ([WeiboSDK isWeiboAppInstalled]) {
        WBMessageObject *message = [WBMessageObject message];
        message.text = text;
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"1231";
        webpage.title = title;
        webpage.description = description;
        webpage.thumbnailData = UIImagePNGRepresentation(image);
        webpage.webpageUrl = urlStr;
        message.mediaObject = webpage;
        
        WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:req];
    }else {
        NSLog(@"");
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    NSLog(@"woshizhu");
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = @"发送结果";
        NSString *message = [NSString stringWithFormat:@"响应状态: %d\n响应UserInfo数据: %@\n原请求UserInfo数据: %@",(int)response.statusCode, response.userInfo, response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}





@end
