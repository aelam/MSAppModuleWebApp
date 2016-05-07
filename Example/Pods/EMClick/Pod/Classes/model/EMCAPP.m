//
//  EMCAPP.m
//  EMClickDemo
//
//  Created by flora on 15/9/15.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "EMCAPP.h"
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#import <AFNetworking/AFNetworking.h>
#import <EMSpeed/MSCore.h>
#import <EMSpeed/MSUIKitCore.h>

@implementation EMCAPP

- (id)init
{
    self = [super init];
    if (self) {
        [self loadSettings];
    }
    return self;
}


- (void)loadSettings
{
    
    UIDevice *device = [UIDevice currentDevice];
    self.systemversion = device.systemVersion;
    self.version = MSAppVersion();

    self.guid = [MSUUID getEMUUID];
#ifdef EMUSEIDFA
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    self.idfa = idfa;
#endif
    self.model = device.model;
    self.network = [self networkDescription];
    CGRect rect = [[UIScreen mainScreen] bounds];
    self.resolution = [NSString stringWithFormat:@"%fx%f",rect.size.width,rect.size.height];
}

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeInteger:self.channel forKey:@"channel"];
    [encoder encodeInteger:self.productId forKey:@"productId"];
    [encoder encodeInteger:self.platformId forKey:@"platformId"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.channel = [decoder decodeIntegerForKey:@"channel"];
        self.productId = [decoder decodeIntegerForKey:@"productId"];
        self.platformId = [decoder decodeIntegerForKey:@"platformId"];
        [self loadSettings];
    }
    return self;
}


- (NSString *)networkDescription
{
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    
    switch (status) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return @"WIFI";
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return @"流量";
            break;
        case AFNetworkReachabilityStatusNotReachable:
            return @"未连接";
            break;
        case AFNetworkReachabilityStatusUnknown:
            return @"未知网络";
        default:
            break;
    }
    return nil;
}

@end
