//
//  NSString+utility.h
//  EMStock
//
//  Created by deng flora on 5/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSString(Utility)


/**
*  去掉前后空白处
*
*  @return 处理后的字符串
*/
- (NSString *)ms_trim;


/**
 *  首字母大写
 *
 *  @return 处理后的字符串
 */
- (NSString *)ms_firstLetterCapitalized;


/**
 *  字符串中是否有字母
 *
 *  @return BOOL
 */
- (BOOL)ms_hasLetter;


/**
 *  是否是email格式
 *
 *  @return 正确或错误
 */
- (BOOL)ms_isEmail;


/**
 *  纯数字
 *
 *  @return 正确或错误
 */
- (BOOL)ms_isPureNumber;

- (BOOL)ms_isPureNumandCharacters __deprecated_msg("use `-ms_isPureNumber`");


/**
 *  是否11位纯数字手机号
 *
 *  @return 正确或失败
 */
- (BOOL)ms_isPhoneNumber;


/**
 *  将流量字符串转化, 流量值(byte), 转化为带K,M,G,T的字符串, 例如1204 -> 1KB
 *
 *  @param flowLen 流量值(byte)
 *
 *  @return 转换后的字符串
 */
+ (NSString *)ms_stringWithFlowLength:(int)length;


/**
 *  纯数字电话号码, 转换为带-号的电话号码格式
 *
 *  @return 电话号码格式字符串
 */
- (NSString *)ms_phoneFormatterString;


/**
 *  获取时间戳
 *
 *  @return 时间戳字符串
 */
+ (NSString *)ms_generateTimestamp;


/**
 *  生成一个UUID
 *
 *  @return UUID字符串
 */
+ (NSString *)ms_generateUUID;

/**
 *  判断字符串是否存在某个字符串中
 *  为了兼容iOS 8以前版本，iOS8之后可以用containsString方法
 *  @param string 要判断的字符串
 *
 *  @return YES:存在，NO：不存在
 */
- (BOOL)includeString:(NSString *)string;

@end

