//
//  NSString+URLHelper.m
//  EMSpeed
//
//  Created by ryan on 15/10/30.
//
//

#import "NSString+URLHelper.h"

@implementation NSString (URLHelper)

- (NSString *)ms_replaceURLPlus
{
    return [self stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
}

- (NSDictionary *)ms_toResponseDictionary {
    return [self ms_toParameters];
}

- (NSDictionary *)ms_toParameters {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *arr1 = [self componentsSeparatedByString:@"&"];
    
    for (int i = 0; i < [arr1 count]; i++)
    {
        NSString *sub = [arr1 objectAtIndex:i];
        NSArray *arr2 = [sub componentsSeparatedByString:@"="];
        if ([arr2 count]>=2) {
            NSString *key = [arr2 objectAtIndex:0];
            NSString *value = [arr2 objectAtIndex:1];
            [dict setObject:value forKey:key];
        }
    }
    return dict;
}


- (BOOL)ms_isValidateURL
{
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:self];
}


@end
