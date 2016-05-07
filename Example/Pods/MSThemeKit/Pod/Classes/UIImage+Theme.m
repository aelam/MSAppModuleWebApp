//
//  UIImage+Theme.m
//  Pods
//
//  Created by ryan on 2/29/16.
//
//

#import "UIImage+Theme.h"
#import "MSThemeManager.h"

@implementation UIImage (Theme)

+ (UIImage *)imageForKey:(NSString *)key {
    return [MSThemeManager imageForKey:key];
}

@end


@implementation UIImage(NameBasedThemeImage)

+ (UIImage *)themeImageNamed:(NSString *)name
{
    UIImage *image = [UIImage localThemeImageNamed:name];
    if (image == nil)
    {
        image =  [UIImage imageNamed:name];
    }
    return image;
}

+ (UIImage *)themeImageNamed:(NSString *)name extension:(NSString *)ext
{
    UIImage *image = [UIImage localThemeImageNamed:name extension:ext];
    if (image == nil)
    {
        image =  [UIImage imageNamed:name];
    }
    return image;
}

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
+ (UIImage *)localThemeImageNamed:(NSString *)name extension:(NSString*)ext
{
    NSString *themeName = [MSThemeManager currentTheme];
    NSString *imageName = [name stringByAppendingFormat:@"_%@",themeName];
    return [UIImage imageNamed:imageName];
}

+ (UIImage *)localThemeImageNamed:(NSString *)name
{
    return [UIImage localThemeImageNamed:name extension:nil];
}


@end
