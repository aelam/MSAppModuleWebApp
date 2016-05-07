//
//  NSObject+StringFormat.m
//  EMSpeed
//
//  Created by zhangzhiyao on 14-10-20.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "NSObject+StringFormat.h"

@implementation NSObject(StringFormat)

- (id)decimalFormat
{
    if ([self respondsToSelector:@selector(floatValue)]) {
        float data = [(NSString *)self floatValue];
        return [NSString stringWithFormat:@"%.2f",data];
    }
    return self;
}

- (id)percentageFormat
{
    if ([self respondsToSelector:@selector(floatValue)]) {
        float data = [(NSString *)self floatValue] * 100;
        return [NSString stringWithFormat:@"%.2f%%",data];
    }
    return self;
}

- (id)percentageFormatNoneCalc
{
    if ([self respondsToSelector:@selector(floatValue)]) {
        float data = [(NSString *)self floatValue];
        return [NSString stringWithFormat:@"%.2f%%",data];
    }
    return self;
}

- (id)integerFormat
{
    if ([self respondsToSelector:@selector(intValue)]) {
        int data = [(NSString *)self intValue];
        return [NSString stringWithFormat:@"%d",data];
    }
    return self;
}

- (id)longFormat
{
    if ([self respondsToSelector:@selector(intValue)]) {
        long long data = [(NSString *)self longLongValue];
        return [NSString stringWithFormat:@"%lld",data];
    }
    return self;
}

- (id)floatFormat
{
    if ([self respondsToSelector:@selector(floatValue)]) {
        float data = [(NSString *)self floatValue];
        return [NSString stringWithFormat:@"%f",data];
    }
    return self;
}

- (id)shortDateFormat
{
    if ([self isKindOfClass:[NSString class]]) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:(NSString *)self];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        return [formatter stringFromDate:date];
    }
    return nil;
}

- (id)shortDateFormatWithSeparatorT
{
    if ([self isKindOfClass:[NSString class]]) {
        NSArray *dateArray = [(NSString*)self componentsSeparatedByString:@"T"];
        if ([dateArray count] >= 1) {
            return [dateArray objectAtIndex:0];
        }
    }
    return nil;
}

- (id)nullToNil
{
    if ([self isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return self;
}

@end
