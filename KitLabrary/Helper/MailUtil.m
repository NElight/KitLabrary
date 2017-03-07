

//
//  MailUtil.m
//  UnityFootball
//
//  Created by Yioks-Mac on 16/11/18.
//  Copyright © 2016年 Yioks. All rights reserved.
//

#import "MailUtil.h"
#import <MessageUI/MessageUI.h>

extern extern NSString *getFightFilePath();

@interface MailUtil ()<MFMailComposeViewControllerDelegate>

@end

@implementation MailUtil

- (void)sendFightXmlFile:(UIViewController *)viewController {
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送邮件"
                                                         message:@"当前系统版本不支持应用内发送邮件功能，您可以使用mailto方法代替"
                                                        delegate:self
                                               cancelButtonTitle:@"我知道啦"
                                               otherButtonTitles: nil];
        [alert show];
        
        return;
    }
    if (![mailClass canSendMail]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送邮件"
                                                         message:@"用户没有设置邮件账户"
                                                        delegate:self
                                               cancelButtonTitle:@"我知道啦"
                                               otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if (!mc) {
        NSLog(@"设备还没有添加邮件账户");
        return;
    }
    mc.mailComposeDelegate = self;
    [mc setSubject:@"Hello, World!"];
    [mc setToRecipients:[NSArray arrayWithObject:@"pingxh@yioks.com"]];
    //    [mc setCcRecipients:[NSArray arrayWithObject:@"xxxxx@163.com"]];
    //    [mc setBccRecipients:[NSArray arrayWithObject:@"secret@gmail.com"]];
    [mc setMessageBody:@"Hello,slick!!!\n\nCome here, I need you!" isHTML:NO];
    
    NSString *title = [NSString stringWithFormat:@"【联系我们】"];
    [mc setSubject:title];
    

    
    //添加一个pdf附件
    NSString *file = getFightFilePath();
    NSData *xml = [NSData dataWithContentsOfFile:file];
    [mc addAttachmentData:xml mimeType:@"text/xml" fileName: @"fight.xml"];
    
    NSString *emailBody = @"eMail 正文";
    [mc setMessageBody:emailBody isHTML:YES];
    
    [viewController presentViewController:mc animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
