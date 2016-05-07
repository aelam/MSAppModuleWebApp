//
//  NSString+BASE64.m
//  Eggorder
//
//  Created by ryan on 10/26/14.
//  Copyright (c) 2014 TapPal. All rights reserved.
//

#import "NSString+BASE64.h"

@implementation NSString (BASE64)

- (NSString *)base64 {
    NSData* originData = [self dataUsingEncoding:NSASCIIStringEncoding];
    NSString* encodedResult = [originData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return encodedResult;
}

- (NSString *)base64Decoded {
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString* decodedString = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    return decodedString;
}


@end
