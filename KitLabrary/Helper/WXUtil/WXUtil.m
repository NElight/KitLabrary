//
//  WXUtil.m
//  UnityFootball
//
//  Created by Yioks-Mac on 17/1/18.
//  Copyright © 2017年 Yioks. All rights reserved.
//

#import "WXUtil.h"


@interface WXUtil ()

@end


@implementation WXUtil

+ (instancetype)sharedManager {
    static WXUtil *instance = nil;
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
        [WXApi registerApp:@"wx000b10c4b5f48086"];
    }
    return self;
}

- (void)shareTextMessage:(NSString *)message withScene:(int)scene{
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.text = message;
    req.bText = YES;
    req.scene = scene;
    BOOL rel = [WXApi sendReq:req];
    NSLog(@"%d", rel);
}

- (void)shareImageMessage:(UIImage *)image withScene:(int)scene {
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:image];
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = UIImagePNGRepresentation(image);
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
}

- (void)shareVideoMessage:(NSString *)title description:(NSString *)description urlStr:(NSString *)urlStr thumbImage:(UIImage *)image withScene:(int)scene {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:image];
    
    WXVideoObject *videoObject = [WXVideoObject object];
    videoObject.videoUrl = urlStr;
    videoObject.videoLowBandUrl = videoObject.videoUrl;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
}

- (void)shareNetMessage:(NSString *)title description:(NSString *)description urlStr:(NSString *)urlStr thumbImage:(UIImage *)image withScene:(int)scene {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:image];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = urlStr;
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req];
}


- (void)onReq:(BaseReq *)req {
    
}

- (void)onResp:(BaseResp *)resp {
    
}

@end
