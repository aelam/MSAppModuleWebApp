//
//  NSDictionary+EMString.h
//  EMSpeed
//
//  Created by Lyy on 15/11/26.
//  Copyright © 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSONString)

/**
 *  json to string,
 *  Setting the NSJSONWritingOptions is 0 ,the most compact possible JSON will be generated
 *  @return string
 */

- (NSString *)jsonString;

/**
 *  json to string,
 *  Setting the NSJSONWritingPrettyPrinted option will generate JSON with whitespace designed to make the output more readable.
    If that option is not set, the most compact possible JSON will be generated.
 *  @param opt NSJSONWritingOptions
 *
 *  @return string
 */
- (NSString *)jsonStringOptions:(NSJSONWritingOptions)opt;

@end
