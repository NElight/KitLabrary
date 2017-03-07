//
//  MailUtil.h
//  UnityFootball
//
//  Created by Yioks-Mac on 16/11/18.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MailUtil : NSObject

- (void)sendFightXmlFile:(UIViewController*)viewController;

@end
