/*
 *  pinyin.h
 *  Chinese Pinyin First Letter
 *
 *  Created by George on 4/21/10.
 *  Copyright 2010 RED/SAFI. All rights reserved.
 *
 */


/**
 *  取一段文字拼音首字母
 *
 *  @param hanzi 文字
 *
 *  @return 拼音首字母
 *
 * // Example
 *
 * #import "pinyin.h"
 *
 * NSString *hanyu = @"中国共产党万岁！";
 * for (int i = 0; i < [hanyu length]; i++)
 * {
 *     printf("%c", pinyinFirstLetter([hanyu characterAtIndex:i]));
 * }
 *
 */
char pinyinFirstLetter(unsigned short hanzi);


/**
 *  文字
 *
 *  @param hanzi 文字
 *
 *  @return 匹配汉子, 如果是汉子返回首拼音, 如果不是拼音返回#
 */
char matchHanzi(unsigned short hanzi);
