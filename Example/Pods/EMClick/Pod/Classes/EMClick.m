//
//  EMClick.m
//  EMClick
//
//  Created by flora on 15/9/15.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "EMClick.h"
#import "EMClickManager.h"

@interface EMClick()

@end

@implementation EMClick

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
                   channel:(NSInteger)channel
{
    EMClickManager *cm = [EMClickManager sharedManager];
    cm.reportPolicy = reportPolicy;
    
    EMCAPP *app = cm.app;
    app.productId = productId;
    app.platformId = platformId;
    app.channel = channel;
    
}

+ (void)updateUserAttributes:(NSDictionary *)userAttributes
{
    EMClickManager *cm = [EMClickManager sharedManager];
    cm.userAttributes = userAttributes;
}

#pragma mark -
#pragma mark 上传数据

/**
 *  上传用户数据
 */
+ (void)uploadUserData
{
    EMClickManager *cm = [EMClickManager sharedManager];
    [cm uploadUserData];
}

/**
 *  上传页面统计数据
 */
+ (void)uploadPageData
{
    EMClickManager *cm = [EMClickManager sharedManager];
    [cm uploadPageData];
}


+ (void)debugMode:(BOOL)debug
{
    [EMClickManager sharedManager].debugEnabled = debug;
}


+ (void)event:(NSString *)event {
    [self event:event attributes:nil];
}

+ (void)event:(NSString *)event attributes:(NSDictionary *)attributes {
    
    EMClickManager *cm = [EMClickManager sharedManager];
    [cm event:event attributes:attributes];
}

+ (void)beginLogPageView:(NSString *)pageId {
    EMClickManager *cm = [EMClickManager sharedManager];
    [cm beginLogPageView:pageId];
}

+ (void)endLogPageView:(NSString *)pageId attributes:(NSDictionary *)attributes {
    EMClickManager *cm = [EMClickManager sharedManager];
    [cm endLogPageView:pageId attributes:attributes];
}



@end


@implementation EMClick(Attributes)

+ (void)event:(NSString *)event URL:(NSString *)URL {
    [self event:event attributes:@{@"url":[URL length]>0?URL:@""}];
}

+ (void)event:(NSString *)event name:(NSString *)name {
    [self event:event attributes:@{@"name":[name length]>0?name:@""}];
}

@end
