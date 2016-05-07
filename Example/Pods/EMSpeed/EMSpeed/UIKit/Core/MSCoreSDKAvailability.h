//
//  EMSDKAvailability.h
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-11.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if __cplusplus
extern "C" {
#endif


/**
 *  是否是iPad用户界面显示
 *
 *  @return 是否是iPad用户界面显示
 */
BOOL MSIsPadUserInterface(void);


/**
 *  是否是iPad设备
 *
 *  @return 是否是iPad设备
 */
BOOL MSIsPadDevice(void);

/**
 *  是否是iPhone设备
 *
 *  @return 是否是iPhone设备
 */
BOOL MSIsPhone(void);


/**
 *  是否是retina屏
 *
 *  @return 是否是retina屏
 */
BOOL MSIsRetina(void);


/**
 *  是否是iPhone5
 *
 *  @return 是否是iPhone5
 */
BOOL MSIsIphone5();


/**
 *  是否是iPhone6
 *
 *  @return 是否是iPhone6
 */
BOOL MSIsIphone6();


/**
 *  是否是iPhone6P
 *
 *  @return 是否是iPhone6P
 */
BOOL MSIsIphone6P();


/**
 *  是否是iPhone5及以上设备
 *
 *  @return 是否是iphone5及以上设备
 */
BOOL MSIsIphone5Above();


/**
 *  是否支持打电话
 *
 *  @return 是否支持打电话
 */
BOOL MSIsPhoneCallSupported() NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");


/**
 *  拨号
 *
 *  @param phoneNumber 电话号码
 *
 *  @return 是否成功
 */
BOOL MSMakePhoneCall(NSString *phoneNumber) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");


#if __cplusplus
}
#endif
