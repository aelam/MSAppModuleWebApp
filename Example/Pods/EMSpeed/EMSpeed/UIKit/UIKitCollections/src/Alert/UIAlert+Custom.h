//
//  UIAlert+EMCustom.h
//  EMStock
//
//  Created by Mac mini 2012 on 14-9-22.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef __cplusplus
extern "C" {
#endif
    
/**
 *  显示告警弹框, 标题, 内容
 *
 *  @param strTitle 标题
 *  @param theText  内容
 */
    extern void showAlert(NSString* strTitle, NSString* theText) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");

/**
 *  显示告警弹框, 标题, 内容, 委托
 *
 *  @param strTitle 标题
 *  @param theText  内容
 *  @param delegate 委托
 */
extern void showAlert2(NSString* strTitle, NSString* theText,id delegate) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");


/**
 *  显示告警弹框, 标题, 内容, 委托
 *
 *  @param strTitle 标题
 *  @param theText  内容
 *  @param delegate 委托
 *  @param tag      标记
 */
extern void showAlert3(NSString* strTitle, NSString* theText,id delegate, int tag) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");


/**
 *  显示告警弹框
 *
 *  @param strTitle    标题
 *  @param theText     内容
 *  @param delegate    委托
 *  @param tag         标记
 *  @param cancelTitle 取消按钮标题
 *  @param otherTitles 其他按钮标题
 *  @param ...         nil
 */
extern void showAlert4(NSString* strTitle, NSString* theText,id delegate, int tag, NSString *cancelTitle, NSString *otherTitles, ...) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");
    
#ifdef __cplusplus
}
#endif

