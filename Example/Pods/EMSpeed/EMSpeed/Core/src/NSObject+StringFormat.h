//
//  NSObject+StringFormat.h
//  EMSpeed
//
//  Created by zhangzhiyao on 14-10-20.
//  Copyright (c) 2014年 flora. All rights reserved.
//
//  把NSString或者NSNumber的数据变成格式化后的字符串

#import <Foundation/Foundation.h>

@interface NSObject(StringFormat)

- (id)decimalFormat;
- (id)percentageFormat;
- (id)integerFormat;
- (id)longFormat;
- (id)percentageFormatNoneCalc;
- (id)floatFormat;
- (id)shortDateFormat;
- (id)shortDateFormatWithSeparatorT;
- (id)nullToNil;

@end
