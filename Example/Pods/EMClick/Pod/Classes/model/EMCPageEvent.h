//
//  EMCPageEvent.h
//  EMClickDemo
//
//  Created by flora on 15/9/15.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMCPageEvent : NSObject<NSCoding>

@property (nonatomic, strong) NSString *eventId;
@property (nonatomic, assign) NSInteger eventCount;
@property (nonatomic, strong) NSDate *eventDate;

@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, strong) NSString *attributeString;

/**
 *  根据eventId 快速创建 page event
 *
 *  @param eventId    事件唯一id
 *  @param attributes 自定义数据
 *
 *  @return EMCPageEvent 对象
 */
+ (instancetype)eventWithId:(NSString *)eventId attributes:(NSDictionary *)attributes;
+ (instancetype)eventWithId:(NSString *)eventId;

@end
