//
//  NSMutableData+postBody.h
//  EMClickDemo
//
//  Created by flora on 15/9/16.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData(postBody)

/**
 *
 *
 *  @param data 上传数据主题
 *
 *  @return 格式化数据
 */
+ (NSData *)postDataWithAppendBody:(NSData *)data;

@end
