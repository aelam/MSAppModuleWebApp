//
//  NSString+EMReadableMoney.m
//  EMSpeed
//
//  Created by ryan on 15/8/5.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "NSString+EMReadable.h"

@implementation NSString (EMReadable)

+ (NSString *)ms_readbleNumberStringFromInt:(NSInteger)value {
    if (value / 100000000 >=1) {
        return [NSString stringWithFormat:@"%0.1f亿", (float)value/100000000.f];
    } else if (value / 10000 >=1) {
        return [NSString stringWithFormat:@"%0.1f万", (float)value/10000.f];
    } else {
        return [NSString stringWithFormat:@"%zd", value];
    }
}

@end
