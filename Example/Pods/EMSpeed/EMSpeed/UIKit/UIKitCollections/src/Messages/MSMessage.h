//
//  EMMessage.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-7.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

/**
 *  发短信
 *
 *  @param phoneNumber 电话号码
 *  @param text        文本
 *  @param parentVC    present在哪个viewcontroller上
 *  @param delegate    delegate, 需要自己去实现的
 *
 *  @return 是否弹出了短信界面
 */
BOOL MSMakeSMS(NSString *phoneNumber, NSString *text, UIViewController *parentVC, id<MFMessageComposeViewControllerDelegate> delegate);

