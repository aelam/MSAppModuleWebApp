//
//  UIFont+Theme.m
//  Pods
//
//  Created by ryan on 2/29/16.
//
//

#import "UIFont+Theme.h"
#import "MSThemeManager.h"


CGFloat _MSScreenWidth(void) NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.")
{
    return [[UIScreen mainScreen] bounds].size.width;
}


CGFloat _MSAdaptiveCofficient() NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.")
{
    static CGFloat coffient = 0;
    if (coffient == 0)
    {
        coffient = _MSScreenWidth()/320.0;
        coffient = [[NSString stringWithFormat:@"%.2f",coffient] floatValue];
    }
    return coffient;
}

@implementation UIFont (Theme)

+ (UIFont *)fontForKey:(NSString *)key {
    return [MSThemeManager fontForKey:key];
}

+ (UIFont *)adaptiveFontForKey:(NSString *)key
{
    UIFont *font = [self fontForKey:key];
    font = [font fontWithSize:font.pointSize * _MSAdaptiveCofficient()];
    return font;
}

+ (UIFont *)adaptiveFontForFont:(UIFont *)font
{
    font = [font fontWithSize:font.pointSize * _MSAdaptiveCofficient()];
    return font;
}


@end

