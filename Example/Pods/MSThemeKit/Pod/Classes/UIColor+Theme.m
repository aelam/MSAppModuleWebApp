//
//  UIColor+Theme.m
//  Pods
//
//  Created by ryan on 2/29/16.
//
//


#import "UIColor+Theme.h"
#import "MSThemeManager.h"

@implementation UIColor (Theme)

+ (UIColor *)colorForKey:(NSString *)key {
    return [MSThemeManager colorForKey:key];
}

@end


