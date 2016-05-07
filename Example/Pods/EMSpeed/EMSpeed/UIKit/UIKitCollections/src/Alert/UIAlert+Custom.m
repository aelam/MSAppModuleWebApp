//
//  UIAlert+EMCustom.m
//  EMStock
//
//  Created by Mac mini 2012 on 14-9-22.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "UIAlert+Custom.h"

void showAlert4(NSString* strTitle, NSString* theText,id delegate, int tag, NSString *cancelTitle, NSString *otherTitles, ...)
{
    UIAlertView *alertView = nil;
    alertView = [[UIAlertView alloc] initWithTitle:strTitle
                                           message:theText
                                          delegate:delegate
                                 cancelButtonTitle:cancelTitle
                                 otherButtonTitles:nil,nil];
    
    alertView.tag = tag;
    
    va_list args;
    va_start(args, otherTitles);
    
    while (otherTitles)
    {
        [alertView addButtonWithTitle:otherTitles];
        otherTitles = va_arg(args, NSString *);
    }
    va_end(args);
    
    [alertView show];
}

void showAlert3(NSString* strTitle, NSString* theText,id delegate, int tag)
{
    showAlert4(strTitle, theText, delegate, tag, @"确认", nil);
}

void showAlert2(NSString* strTitle, NSString* theText,id delegate)
{
    showAlert3(strTitle, theText, delegate, 0);
}

void showAlert(NSString* strTitle, NSString* theText)
{
    showAlert2(strTitle, theText, nil);
}
