//
//  EMClickManager.h
//  EMClickDemo
//
//  Created by flora on 15/9/15.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCAPP.h"
#import "EMCPageView.h"
#import "EMCPageEvent.h"
#import "EMCReportPolicy.h"
#import <AFNetworking/AFURLRequestSerialization.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "MSDataRequestModel.h"
#import "EMClickDebugManager.h"





@interface EMClickManager : EMClickDebugManager
{
    
}

@property (nonatomic, assign) EMReportPolicy reportPolicy;
@property (nonatomic, assign) CGFloat reportInterval;
@property (nonatomic, assign, getter=isDebugEnabled) BOOL debugEnabled;

@property (nonatomic, strong) EMCAPP  *app;
@property (nonatomic, strong) NSDictionary *userAttributes;


+ (instancetype)sharedManager;

#pragma mark -
#pragma mark 事件触发

/**
 *  事件触发
 *
 *  @param eventId    事件Id
 *  @param attributes 事件自定义事件
 */
- (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes;

#pragma mark -
#pragma mark 页面统计触发
/**
 *  在页面打开的时候调用
 *
 *  @param pageId 页面的唯一id
 */
- (void)beginLogPageView:(NSString *)pageId;

/**
 *  在页面结束的时候调用，可添加自定义数据
 *
 *  @param pageId     页面唯一id
 *  @param attributes 自定义数据
 */
- (void)endLogPageView:(NSString *)pageId attributes:(NSDictionary *)attributes;

#pragma mark -
#pragma mark 上传数据

/**
 *  上传用户数据
 */
- (void)uploadUserData;

/**
 *  上传页面统计数据
 */
- (void)uploadPageData;


- (NSString *)userUrlString;
- (NSString *)pageUrlString;
@end

