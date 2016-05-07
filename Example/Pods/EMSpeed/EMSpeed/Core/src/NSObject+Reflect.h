//
//  NSObject+Reflect.h
//  EMSpeed
//
//  Created by flora on 13-12-9.
//
//参考：http://blog.csdn.net/shulianyong/article/details/9060825

#import <Foundation/Foundation.h>

@interface NSObject (Reflect)

/**
 *  属性反射
 *  当前对象有field中的属性时，设置对应的值
 *
 *  @param dataSource
 *
 *  @return 是否成功
 */
- (BOOL)ms_reflectDataFromOtherObject:(NSObject*)dataSource;


/**
 *  属性反射
 *  当前对象有field中的属性时，设置对应的值
 *
 *  @param dict 字典
 *
 *  @return 是否成功
 */
- (BOOL)ms_reflectDataFromOtherDictionary:(NSDictionary*)dictionary;


/**
 *  属性反射
 *  当前对象有field中的属性时，设置对应的值
 *
 *  @param dataSource
 *
 *  @return 是否成功
 */
/**
 *会遍历父类的参数（NSObject）
 */
- (BOOL)ms_reflectDataRecursionFromOtherDictionary:(NSDictionary*)dataSource;


/**属性反射
 *当前对象有field中的属性时，设置对应的值
 */
//
- (BOOL)ms_setField:(NSArray *)field list:(NSArray *)list;

@end


@interface NSArray(caseInsensitiveCompare)

/**
 *如果忽略大小写相同返回值
 */
- (NSString *)ms_containCaseInsensitiveString:(NSString *)string;

@end