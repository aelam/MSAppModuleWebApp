//
//  MSThemeModuleWeb.m
//  Pods
//
//  Created by ryan on 06/12/2016.
//
//

#import "MSThemeModuleWeb.h"

@implementation MSThemeModuleWeb

+ (void)load {
    ThemeRegisterModule(self);
}

+ (MSThemeModulePriority)priority {
    return MSThemeModulePriorityLow;
}

- (NSString *)moduleName {
    return @"web";
}

- (NSArray *)supportThemes {
    return @[@"white", @"black"];
}

- (NSString *)plistDir {
    return [[NSBundle bundleForClass:[self class]] bundlePath];
}


@end
