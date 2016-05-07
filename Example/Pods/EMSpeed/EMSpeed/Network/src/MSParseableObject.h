//
//  EMParseableObject.h
//  F
//
//  Created by Ryan Wang on 4/14/15.
//  Copyright (c) 2015 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSParser.h"

/**
 *  数据解析的对象
 */
@interface MSParseableObject : NSObject <MSParser>


/**
 *  传入JSON数组, 返回对应的对象数组
 *
 *  @param array JSON数组
 *
 *  @return 对应的对象数组
 */
+ (NSMutableArray *)parseArray:(NSArray *)array;


/**
 *  根据JSON数据, 实例化对象
 *
 *  @param info JSON数据
 *
 *  @return 对象
 */
+ (instancetype)instanceWithData:(NSDictionary *)info;


/**
 *  解析JSON数据,
 *
 *  @param info JSON数据
 *
 *  @return 对象
 */
- (instancetype)parse:(NSDictionary *)info;

/**
 *  解析JSON数据,
 *
 *  @param info JSON数据
 *  @param options 预留
 *
 *  @return 对象
 */
- (instancetype)parse:(NSDictionary *)info options:(NSUInteger)options;

@end

