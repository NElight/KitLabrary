//
//  QQUtil.m
//  UnityFootball
//
//  Created by Yioks-Mac on 17/1/18.
//  Copyright © 2017年 Yioks. All rights reserved.
//

#import "QQUtil.h"


@interface QQUtil ()

@property (nonatomic, strong) TencentOAuth *oAuth;

@property (nonatomic, strong) NSArray *permissions;


@end

@implementation QQUtil

+ (instancetype)sharedManager {
    static QQUtil *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.oAuth = [[TencentOAuth alloc]initWithAppId:@"1105881037" andDelegate:self];
        self.permissions = @[@"get_user_info", @"get_simple_userinfo", @"add_t"];
    }
    return self;
}

- (void)loginWithQQ {
    [self.oAuth authorize:self.permissions inSafari:NO];
}

#pragma mark - TencentSessionDelegate
- (void)tencentDidLogin {
    if (self.oAuth.accessToken && 0 != self.oAuth.accessToken.length) {
        NSLog(@"qq login success -------- token= %@", self.oAuth.accessToken);
    }else {
        NSLog(@"qq login failed");
    }
}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    if (cancelled) {
        NSLog(@"qq login user canceled");
    }else {
        NSLog(@"qq login failed");
    }
}

- (void)tencentDidNotNetWork {
    NSLog(@"qq login network failed");
}

- (void)shareMessage:(id)message{
    
    id QQApiObj = nil;
    SendMessageToQQReq *req = nil;
    
    
    if ([message isKindOfClass:[NSString class]]) {
        QQApiTextObject *txtObj = [QQApiTextObject objectWithText:message];
        QQApiObj = txtObj;
    }
    if ([message isKindOfClass:[UIImage class]]) {
        NSData *data = UIImagePNGRepresentation(message);
        QQApiImageObject *imgObj = [QQApiImageObject objectWithData:data previewImageData:data title:@"title" description:@"description"];
        QQApiObj = imgObj;
    }
    
    req = [SendMessageToQQReq reqWithContent:QQApiObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    NSLog(@"%d", sent);
}

- (void)onReq:(QQBaseReq *)req {
    NSLog(@"%@", req);
}

- (void)onResp:(QQBaseResp *)resp {
    NSLog(@"%@", resp);
}


@end
