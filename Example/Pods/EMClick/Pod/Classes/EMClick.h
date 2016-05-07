//
//  EMClick.h
//  EMClick
//
//  Created by flora on 15/9/15.
//  Copyright (c) 2015年 flora. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "EMCReportPolicy.h"

@interface EMClick : NSObject

/**
 *  启动配置EMClick，
 *
 *  @param productId    产品Id
 *  @param platformId   平台Id
 *  @param reportPolicy 上报策略
 *  @param channel      渠道号
 */
+ (void)startWithProductId:(NSInteger)productId
                platformId:(NSInteger)platformId
              reportPolicy:(EMReportPolicy)reportPolicy
                   channel:(NSInteger)channel;

/**
 *  启动配置EMClick，
 *
 *  @param userAttributes    用户统计接口自定义参数
 */
+ (void)updateUserAttributes:(NSDictionary *)userAttributes;

#pragma mark -
#pragma mark 上传数据

/**
 *  上传用户数据
 */
+ (void)uploadUserData;

/**
 *  上传页面统计数据
 */
+ (void)uploadPageData;


+ (void)debugMode:(BOOL)debug;

+ (void)event:(NSString *)event;
+ (void)event:(NSString *)event attributes:(NSDictionary *)attributes;

+ (void)beginLogPageView:(NSString *)pageId;
+ (void)endLogPageView:(NSString *)pageId attributes:(NSDictionary *)attributes;

@end

@interface EMClick(Attributes)
+ (void)event:(NSString *)event URL:(NSString *)URL;
+ (void)event:(NSString *)event name:(NSString *)name;
@end
