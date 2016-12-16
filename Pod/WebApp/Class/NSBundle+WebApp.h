//
//  NSBundle+WebApp.h
//  Pods
//
//  Created by ryan on 07/12/2016.
//
//

#import <Foundation/Foundation.h>

@interface NSBundle (WebApp)

+ (instancetype)webAppBundle;

// 用于自定义资源包, 可以放置在mainBundle. 但要保持文件名一致 并且齐全
+ (void)setWebAppResourceBundle:(NSBundle *)bundle;
+ (instancetype)webAppResourceBundle;

@end
