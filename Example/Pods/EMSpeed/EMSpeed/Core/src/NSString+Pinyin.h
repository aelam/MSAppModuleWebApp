#import <Foundation/Foundation.h>

@interface NSString(Pinyin)

/**
 *  匹配拼音字母, 判断拼音字母字符串是否完全匹配, 包括了一些多音字的判断
 *
 *  @param pinyin 传入需要匹配的拼音字母
 *
 *  @return 是否匹配
 */

- (BOOL)ms_matchPinYin:(NSString*)pinyin;


/**
 *  取字符串的首个拼音字母, 包括一些多音字的判断
 *
 *  @return 首字母字符串
 */
- (NSString *)ms_pinyinFirstLetterArray;

@end
