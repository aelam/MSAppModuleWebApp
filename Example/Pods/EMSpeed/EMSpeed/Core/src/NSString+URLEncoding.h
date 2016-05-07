//
//  EMEncoding.h
//  EMSpeed
//
//  Created by Mac mini 2012 on 15-2-6.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EncodingAdditions)

/**
 *  URL encode
 *
 *  @return encode后的字符串
 */
- (NSString *)URLEncodedString;


/**
 *  URL decode
 *
 *  @return decode后的字符串
 */
- (NSString *)URLDecodedString;


// 非标准转行 多了一个-号 问题解决以后 这个问题就删除
- (NSString *)fixMe_URLEncodedString;

@end
