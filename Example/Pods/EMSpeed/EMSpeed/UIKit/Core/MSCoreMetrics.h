//
//  EMCoreMetrics.h
//  EMStock
//
//  Created by flora on 14-9-11.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#if defined __cplusplus
extern "C" {
#endif

/**
 *  屏幕bounds
 *
 *  @return 屏幕bounds
 */
CGRect MSScreenBounds(void);

/**
 *  屏幕高度
 *
 *  @return 屏幕高度
 */
CGFloat MSScreenHeight(void) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");


/**
 *  屏幕宽度
 *
 *  @return 屏幕宽度
 */
CGFloat MSScreenWidth(void) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");


/**
 *  屏幕内容尺寸
 *
 *  @return 屏幕内容尺寸
 */
CGRect MSContentFrame(void);


/**
 *  屏幕内容高度, 高度少状态栏20px
 *
 *  @return 屏幕高度
 */
CGFloat MSContentHeight(void);


/**
 *  屏幕内容宽度
 *
 *  @return 屏幕宽度
 */
CGFloat MSContentWidth(void);


/**
 *  导航栏高度
 *
 *  @return 导航栏高度
 */
CGFloat MSNavigationBarHeight(void);


/**
 *  Tabbar高度
 *
 *  @return Tabbar高度
 */
CGFloat MSTabBarHeight(void);


/**
 *  状态栏高度
 *
 *  @return 状态栏高度
 */
CGFloat MSStatusBarHeight(void) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");


/**
 *  屏幕缩放比例
 *
 *  @return 屏幕缩放比例
 */
CGFloat MSScreenScale(void);


/**
 *  根据分辨率返回缩放比例, 基于320px
 */
CGFloat MSAdaptiveCofficient() NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");


/**
 *  根据缩放比, 计算出适配所需的高度宽度
 *
 *  @param wh 输入长度
 *
 *  @return 计算后的长度
 */
CGFloat MSAdjustedWH(CGFloat wh) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");;


/**
 *  默认字符串-10.00%宽度
 *
 *  @param font 字体
 *
 *  @return 字符串宽度
 */
CGFloat MSDefaultValueWidth(UIFont *font);



#if defined __cplusplus
};
#endif