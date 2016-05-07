//
//  MSThemeKitManager.h
//  Pods
//
//  Created by Mac mini 2012 on 15/10/22.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString * const MSThemeManagerDidChangeTheme;


@interface MSThemeManager : NSObject {

}

+ (BOOL)registerThemes:(NSArray *)themes modules:(NSArray *)modules;
+ (void)changeTheme:(NSString *)theme;// 切换主题色, 成功后会发MSThemeManagerDidChangeTheme通知

+ (NSString *)currentTheme; // 当前主题色名称
+ (NSString *)tempTheme; // 临时主题色

+ (UIColor *)colorForKey:(NSString *)key;
+ (UIFont *)fontForKey:(NSString*)key;
+ (UIImage *)imageForKey:(NSString *)key;

+ (void)useTempTheme:(NSString *)theme; // 不会发MSThemeManagerDidChangeTheme通知, 必须与restore配对使用
+ (void)restore; // 还原之前的场景颜色


+ (NSString *)colorKeyForKey:(NSString *)key; // 颜色最终所对应的key值
+ (NSString *)colorHexForKey:(NSString *)key; // 取hex颜色值

@end

