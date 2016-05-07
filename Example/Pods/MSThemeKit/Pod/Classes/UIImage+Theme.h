//
//  UIImage+Theme.h
//  Pods
//
//  Created by ryan on 2/29/16.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Theme)

+ (UIImage *)imageForKey:(NSString *)key;

@end


@interface UIImage(NameBasedThemeImage)


+ (UIImage *)themeImageNamed:(NSString *)name;
+ (UIImage *)themeImageNamed:(NSString *)name extension:(NSString *)ext;
/**
 *  从本地存储文件中读取主题色相关图片
 *  获取当前主题色文件存储地址
 *  获取当前主题色图片名称
 *  从本地读取主题色图片
 *
 *  @param name 图片名称
 *  @param ext  图片文件类型
 *
 *  @return 图片
 */
+ (UIImage *)localThemeImageNamed:(NSString *)name extension:(NSString*)ext;
+ (UIImage *)localThemeImageNamed:(NSString *)name;

@end