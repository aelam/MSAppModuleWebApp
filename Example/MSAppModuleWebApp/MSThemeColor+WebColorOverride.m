//
//  MSThemeColor+WebColorOverride.m
//  MSAppModuleWebApp
//
//  Created by ryan on 16/12/2016.
//  Copyright © 2016 Ryan Wang. All rights reserved.
//

#import "MSThemeColor+WebColorOverride.h"
#import <MSAppModuleWebApp/MSThemeColor+WebApp.h>

@implementation MSThemeColor (WebColorOverride)

+ (UIColor *)web_navbarItemTextColor {
    return [UIColor whiteColor];
}

+ (UIColor *)web_bgColor {
    return [UIColor whiteColor];
}

@end
