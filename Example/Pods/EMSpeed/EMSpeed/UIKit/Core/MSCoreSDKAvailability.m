//
//  EMSDKAvailability.m
//  EMStock
//
//  Created by Mac mini 2012 on 15-2-11.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MSCoreSDKAvailability.h"
#import "MSCoreMetrics.h"


BOOL MSIsPadUserInterface(void)
{
    static NSInteger isPad = -1;
    if (isPad < 0) {
        isPad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? 1 : 0;
    }
    return isPad > 0;
}

BOOL MSIsPadDevice(void)
{
    return [[UIDevice currentDevice].model rangeOfString:@"Pad"].location != NSNotFound;
}

BOOL MSIsPhone(void)
{
    static NSInteger isPhone = -1;
    if (isPhone < 0) {
        isPhone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 1 : 0;
    }
    return isPhone > 0;
}


BOOL MSIsRetina(void)
{
    return MSScreenScale() >= 2.f;
}


BOOL MSIsIphone5()
{
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO;
}


BOOL MSIsIphone5Above()
{
    return MSIsIphone5() || MSIsIphone6() || MSIsIphone6P();
}


BOOL MSIsIphone6()
{
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
        return (MAX([[UIScreen mainScreen] currentMode].size.width, [[UIScreen mainScreen] currentMode].size.height) < 2208) && (MAX([[UIScreen mainScreen] currentMode].size.width, [[UIScreen mainScreen] currentMode].size.height)>1136);
    }
    
    return NO;
}


BOOL MSIsIphone6P()
{
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
        return  MAX([[UIScreen mainScreen] currentMode].size.width, [[UIScreen mainScreen] currentMode].size.height) >= 2208;
    }
    
    return NO;
}


BOOL MSIsPhoneCallSupported()
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}


BOOL MSMakePhoneCall(NSString *phoneNumber)
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        return [[UIApplication sharedApplication] openURL:url];
    }
    else{
        return NO;
    }
}


