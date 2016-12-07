//
//  UIColor+WebApp.m
//  Pods
//
//  Created by ryan on 06/12/2016.
//
//

#import "UIColor+WebApp.h"
#import <MSThemeKit/MSThemeKit.h>

@implementation UIColor (WebApp)

+ (UIColor *)web_statusBarColor {
    return [MSThemeManager colorForKey:NSStringFromSelector(_cmd)];
}

+ (UIColor *)web_bgColor {
    return [MSThemeManager colorForKey:NSStringFromSelector(_cmd)];
}

+ (UIColor *)web_navbarItemTextColor {
    return [MSThemeManager colorForKey:NSStringFromSelector(_cmd)];
}

@end
