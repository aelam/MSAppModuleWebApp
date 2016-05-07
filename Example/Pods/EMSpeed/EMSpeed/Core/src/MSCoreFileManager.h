//
//  MSCoreFileManager.h
//  Core
//
//  Created by Mac mini 2012 on 15-3-9.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  与文件管理相关的一些工具方法
 */


#ifdef __cplusplus
extern "C" {
#endif

NSString *EMGetDefaultImageDirectory();
    
/**
 *  文件路径URL
 *
 *  @param path 文件路径
 *
 *  @return 文件URL
 */
NSURL* MSFileURL(NSString *path);


/**
 *  文件是否存在
 *
 *  @param filePath 文件路径
 *
 *  @return 文件是否存在
 */
BOOL MSIsFileExistAtPath(NSString *filePath);


/**
 *  从main bundle中读取文件(数组)
 *
 *  @param fileName 文件名
 *
 *  @return 数组格式
 */
NSArray* MSArrayFromMainBundle(NSString *fileName);


/**
 *  从main bundle中读取文件(字典)
 *
 *  @param fileName 文件名
 *
 *  @return 字典格式
 */
NSDictionary* MSDictionaryFromMainBundle(NSString *fileName);


/**
 *  从caches文件夹中读取文件(数组)
 *
 *  @param filename 文件名
 *
 *  @return 数组格式
 */
NSArray* MSArrayFromCachesDirectory(NSString *filename);


/**
 *  从caches文件夹中读取文件(字典)
 *
 *  @param filename 文件名
 *
 *  @return 字典格式
 */
NSDictionary* MSDictionaryFromDocumentDirectory(NSString *filename);


/**
 *  将数组保存到caches文件夹中
 *
 *  @param filename 文件名
 *  @param array    数组
 *
 *  @return 是否成功
 */
BOOL MSSaveArrayToCachesDirectory(NSString *filename, NSArray *array);



/**
 *  将字典保存到caches文件夹中
 *
 *  @param filename   文件名
 *  @param dictionary 字典
 *
 *  @return 是否成功
 */
BOOL MSSaveDictionaryToCachesDirectory(NSString *filename, NSDictionary *dictionary);


/**
 *  创建文件夹
 *
 *  @param dir 文件夹路径
 *
 *  @return 是否成功
 */
BOOL MSFileManagerCreateDirectory(NSString *dir);


/**
 *  删除文件夹
 *
 *  @param dir 文件夹路径
 *
 *  @return 是否成功
 */
BOOL MSFileManagerRemoveDirectory(NSString *dir);


/**
 *  删除文件
 *
 *  @param 文件路径
 *
 *  @return 是否成功
 */
BOOL MSFileManagerRemoveFile(NSString *filePath);


/**
 *  保存文件
 *
 *  @param file 文件路径
 *  @param data 数据
 *
 *  @return 是否成功
 */
BOOL MSFileManagerSaveFile(NSString *filePath, NSData *data);


/**
 *  获取从文件中读取数据
 *
 *  @param filePath 文件路径
 *
 *  @return 数据
 */
NSData *MSFileManagerFileAtPath(NSString *filePath);

/**
 *  设置一个默认的图片保存路径
 *
 *  @param directory 默认的图片路径
 */
void MSSetDefaultImageDirectory(NSString *directory); // caches/pic/


/**
 *  删除文件
 *
 *  @param filePath 文件路径     
 *
 *  @return 是否成功
 */
BOOL MSFileManagerRemoveFile(NSString *filePath);


/**
 *  保存文件
 *
 *  @param filePath 文件路径
 *  @param data 数据
 *
 *  @return 是否成功
 */
BOOL MSFileManagerSaveFile(NSString *filePath, NSData *data);


/**
 *  读取文件
 *
 *  @param filePath 文件路径
 *
 *  @return 数据
 */
NSData *MSFileManagerFileAtPath(NSString *filePath);

/**
 *  根据bundle名+相对路径
 *
 *  @param bundle       bundle名称
 *  @param relativePath 相对路径
 *
 *  @return bundle名+相对路径
 */
NSString* MSPathForMainBundleResource(NSString* relativePath);


/**
 *  根据bundle名+相对路径
 *
 *  @param bundle       bundle名称
 *  @param relativePath 相对路径
 *
 *  @return bundle名+相对路径
 */
NSString* MSPathForBundleResource(NSBundle* bundle, NSString* relativePath);


/**
 *  Documents文件夹下文件绝对路径
 *
 *  @param relativePath 相对路径
 *
 *  @return Documents文件夹路径 + 相对路径
 */
NSString* MSPathForDocumentsResource(NSString* relativePath);


/**
 *  Library文件夹下文件绝对路径
 *
 *  @param relativePath 相对路径
 *
 *  @return Library文件夹路径 + 相对路径
 */
NSString* MSPathForLibraryResource(NSString* relativePath);


/**
 *  Caches文件夹下文件绝对路径
 *
 *  @param relativePath 相对路径
 *
 *  @return Caches文件夹路径 + 相对路径
 */
NSString* MSPathForCachesResource(NSString* relativePath);



    
#ifdef __cplusplus
}
#endif