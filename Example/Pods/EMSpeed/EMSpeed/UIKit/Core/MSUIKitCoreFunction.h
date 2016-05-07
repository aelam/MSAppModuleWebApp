//
//  EMCoreFunction.h
//  EMStock
//
//  Created by flora on 14-9-10.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * 获取包的唯一标示
 *
 *  @return bundle信息
 */
NSString *MSBundleIdenfiter();


/**
 *  应用名称
 *
 *  @return 应用显示的名称
 */
NSString* MSAppDisplayName();


/**
 *  获取版本表示，一般格式为3.3.1
 *
 *  @return 版本号
 */
NSString* MSAppVersion();



/**
 *  当前iOS版本号
 *
 *  @return 当前iOS版本号
 */
float MSOSVersion(void);



/**
 *  当前是否是竖屏
 *
 *  @return 当前是否是竖屏
 */
BOOL MSIsPortrait() NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");


/**
 *  当前是否是横屏
 *
 *  @return 当前是否是横屏
 */
BOOL MSIsLandscape() NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.");



//    /**
//     *  当前iOS版本号, 是否小于输入版本号
//     *
//     *  @param version 输入版本号
//     *
//     *  @return 当前iOS版本号, 是否小于输入版本号
//     */
//    BOOL MSOSVersionLessThan(float version);
//    
//    
//    /**
//     *  当前iOS版本号, 是否等于输入版本号
//     *
//     *  @param version 输入版本号
//     *
//     *  @return 当前iOS版本号, 是否等于输入版本号
//     */
//    BOOL MSOSVersionEqual(float version);
//    
//    
//    /**
//     *  当前iOS版本号, 是否大于输入版本号
//     *
//     *  @param version 输入版本号
//     *
//     *  @return 当前iOS版本号, 是否大于输入版本号
//     */
//    BOOL MSOSVersionMoreThan(float version);
//    
//    
//    /**
//     *  当前iOS版本号, 是否小于等于输入版本号
//     *
//     *  @param version 输入版本号
//     *
//     *  @return 当前iOS版本号, 是否小于等于输入版本号
//     */
//    BOOL MSOSVersionEqualOrLessThan(float version);
//    
//    
//    /**
//     *  当前iOS版本号, 是否大于等于输入版本号
//     *
//     *  @param version 输入版本号
//     *
//     *  @return 当前iOS版本号, 是否大于等于输入版本号
//     */
//    BOOL MSOSVersionEqualOrMoreThan(float version);
    
    
#ifdef __cplusplus
}
#endif

