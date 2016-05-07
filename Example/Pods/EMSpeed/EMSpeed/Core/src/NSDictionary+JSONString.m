//
//  NSDictionary+EMString.m
//  EMSpeed
//
//  Created by Lyy on 15/11/26.
//  Copyright © 2015年 flora. All rights reserved.
//

#import "NSDictionary+JSONString.h"

@implementation NSDictionary (JSONString)

- (NSString *)jsonString {
    return [self jsonStringOptions:0];
}

- (NSString *)jsonStringOptions:(NSJSONWritingOptions)opt {
    return [NSDictionary stringWithObject:self options:opt];
}

//data 转 string
+ (NSString *)stringWithObject:(id)object options:(NSJSONWritingOptions)opt{
    NSString *string = nil;
    //    Setting the NSJSONWritingPrettyPrinted option will generate JSON with whitespace designed to make the output more readable. If that option is not set, the most compact possible JSON will be generated.
    NSData *data = [self dataWithObject:object options:opt];
    if (data) {
        string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    return string;
}
//json 转 data
+ (NSData *)dataWithObject:(id)object options:(NSJSONWritingOptions)opt {
    NSData *data = nil;
    if ([NSJSONSerialization isValidJSONObject:object]) {
        data = [NSJSONSerialization dataWithJSONObject:object options:opt error:nil];
    }else{
        NSLog(@"--->>object %@ not a json object",object);
    }
    return data;
}

@end
