//
//  EMMessage.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-7.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSMessage.h"


BOOL MSMakeSMS(NSString *phoneNumber, NSString *text, UIViewController *parentVC, id<MFMessageComposeViewControllerDelegate> delegate)
{
    if ([phoneNumber length] > 0 && [text length] > 0 && parentVC && delegate
        && [MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *msgVC = [[MFMessageComposeViewController alloc] init];
        msgVC.recipients = @[phoneNumber];
        msgVC.body = text;
        msgVC.messageComposeDelegate = delegate;
        [parentVC presentViewController:msgVC animated:YES completion:^{
            
        }];
        
        return YES;
    }
    
    return NO;
}
