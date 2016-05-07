//
//  NSMutableData+postBody.m
//  EMClickDemo
//
//  Created by flora on 15/9/16.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "NSMutableData+postBody.h"

@implementation NSMutableData(postBody)

# pragma mark - 包头

static NSString * const kAFMultipartFormCRLF = @"\r\n";
static NSString * const kAFMultipartFormBoundary = @"Boundary+0xAbCdEfGbOuNdArY";

static inline NSString * AFMultipartFormInitialHeaderBoundary() {
    return [NSString stringWithFormat:@"--Boundary+0xAbCdEfGbOuNdArY\r\nContent-Disposition: form-data; name=\"(null)\"\r\n\r\n\r\n"];
}

static inline NSString * AFMultipartFormInitialBoundary() {
    return [NSString stringWithFormat:@"--%@%@%@", kAFMultipartFormBoundary, kAFMultipartFormCRLF,kAFMultipartFormCRLF];
}

static inline NSString * AFMultipartFormFinalBoundary() {
    return [NSString stringWithFormat:@"%@--%@--%@%@", kAFMultipartFormCRLF, kAFMultipartFormBoundary, kAFMultipartFormCRLF, kAFMultipartFormCRLF];
}

+ (NSData *)postDataWithAppendBody:(NSData *)data {
    NSMutableData *mutableData = [NSMutableData dataWithCapacity:[data length]+256];
    
    [mutableData appendString:AFMultipartFormInitialHeaderBoundary()];
    [mutableData appendString:AFMultipartFormInitialBoundary()];
    [mutableData appendData:data];
    [mutableData appendString:AFMultipartFormFinalBoundary()];
    
    return [NSData dataWithData:mutableData];
}

- (void)appendString:(NSString *)string {
    [self appendData:[string dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
