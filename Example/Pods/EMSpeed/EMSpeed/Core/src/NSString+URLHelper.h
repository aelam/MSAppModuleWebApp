//
//  NSString+URLHelper.h
//  EMSpeed
//
//  Created by ryan on 15/10/30.
//
//

#import <Foundation/Foundation.h>

@interface NSString (URLHelper)

/**
 *  "+"号替换成%2B
 *
 *  @return 替换后的字符串
 */
- (NSString *)ms_replaceURLPlus;


/**
 *  url解成字典
 *
 *  @return 字典
 */
- (NSDictionary *)ms_toResponseDictionary  __deprecated_msg("Use `ms_toParameters`");;
- (NSDictionary *)ms_toParameters;


/**
 *  是否是个合法的URL
 *
 *  @return 是否
 */
- (BOOL)ms_isValidateURL;


@end
