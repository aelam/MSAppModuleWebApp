//
//  NSString+Extended.m
//  EMStock
//
//  Created by deng flora on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString(Utility)

- (NSString *)ms_trim
{
	NSCharacterSet *ws = [NSCharacterSet whitespaceAndNewlineCharacterSet];
	NSString *trimmed = [self stringByTrimmingCharactersInSet:ws];
	return trimmed;
}

- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
    
}

- (NSString *)ms_firstLetterCapitalized
{
    if ([self length]>0) {
        NSString *firstChar = [self substringToIndex:1];
        NSString *tmpStr = [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[firstChar uppercaseString]];
        return tmpStr;
    }
    else{
        return self;
    }
}



- (BOOL)ms_hasLetter
{
    for(int i =0 ;i<[self length]; i++) {
        char c = [self characterAtIndex:i];
        if ((c >='A'&& c<='Z') || (c >='a'&& c<='z')) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)ms_isEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,16}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)ms_isPureNumandCharacters {
    return [self ms_isPureNumber];
}

- (BOOL)ms_isPureNumber;
{
    if([self length] > 0)
    {
        NSString *regex = [NSString stringWithFormat:@"[0-9]{%lu}", (unsigned long)[self length]];
        NSPredicate* _pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL bRes =  ([_pred evaluateWithObject:self]);
        return bRes;
    }
    return NO;
}


- (BOOL)ms_isPhoneNumber
{
    return (11 == [self length]) ? [self ms_isPureNumber] : NO;
}


+ (NSString *)ms_stringWithFlowLength:(int)flowLen
{
    NSString *des = @"Bytes";
    double _size = (double)flowLen;
    //    //转化未kb
    //    if(_size > 1024)
    //    {
    _size = _size / 1024.0;
    des = @"KB";
    //    }
    //转化为M
    if(_size > 1024)
    {
        _size = _size / 1024.0;
        des = @"MB";
    }
    //    //转换为G
    //    if(_size > 1024)
    //    {
    //        _size = _size / 1024.0;
    //        des = @"G";
    //    }
    //
    //    //转换为T
    //    if(_size > 1024)
    //    {
    //        _size = _size / 1024.0;
    //        des = @"T";
    //    }
    return[NSString stringWithFormat:@"%.2f%@",_size,des];
    
}


- (NSString *)ms_phoneFormatterString
{
    if (self.length > 7)
    {
        return [NSString stringWithFormat:@"%@-%@-%@",[self substringToIndex:3],
                [self substringWithRange:NSMakeRange(3, self.length - 7)],
                [self substringFromIndex:self.length-4]];
    }
    else
    {
        return self;
    }
}


#pragma mark 获得时间戳
+ (NSString *)ms_generateTimestamp
{
    return [NSString stringWithFormat:@"%ld", time(NULL)];
}


#pragma mark 获得随时字符串
+ (NSString *)ms_generateUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    return (__bridge NSString *)string;
}

- (BOOL)includeString:(NSString *)string {
    NSRange range = [self rangeOfString:string];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

@end


