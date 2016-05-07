//
//  NSURL+URLTypes.h
//  Pods
//
//  Created by ryan on 2/23/16.
//
//

#import <Foundation/Foundation.h>

@interface NSURL (URLTypes)

/**
 *  判断HOST是否含有apple.com
 *  @return YES/NO
 */
- (BOOL)isAppleURL;

/**
 *  tel://100086
 *
 *  @return YES/NO
 */
- (BOOL)isTelURL;

/**
 *  telprompt://100086
 *
 *  @return YES/NO
 */
- (BOOL)isTelPromptURL;

/**
 *  mail://
 *
 *  @return YES/NO
 */
- (BOOL)isMailURL;

/**
 *  sms://
 *
 *  @return YES/NO
 */
- (BOOL)isSMSURL;

- (BOOL)isHTTP;
- (BOOL)isHTTPS;

@end
