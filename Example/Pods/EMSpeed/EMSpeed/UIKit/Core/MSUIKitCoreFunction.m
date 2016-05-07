//
//  MSUIKitCoreFunction.m
//  EMSpeed
//
//  Created by flora on 14-9-10.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSUIKitCoreFunction.h"

float MSOSVersion(void)
{
    return [[UIDevice currentDevice].systemVersion floatValue];
}


BOOL MSIsPortrait()
{
    return UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]);
}


BOOL MSIsLandscape()
{
    return !MSIsPortrait();
}


NSString *MSBundleIdenfiter()
{
    return [[NSBundle mainBundle] bundleIdentifier];
}


NSString* MSAppDisplayName()
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *displayName = infoDictionary[@"CFBundleDisplayName"];
    return displayName;
}


NSString* MSAppVersion()
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *versionValue = infoDictionary[@"CFBundleShortVersionString"];
    return versionValue ? (NSString *)versionValue :  @"1.0.0";
}
