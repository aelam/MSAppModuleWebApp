//
//  EMWebAppInfo.m
//  EMStock
//
//  Created by ryan on 15/11/24.
//  Copyright © 2015年 flora. All rights reserved.
//

#import "EMWebAppInfo.h"
#import <EMSpeed/MSUIKitCore.h>

// EMAccount 因为回调后的处理和推送的处理不一致最后导致webToken会有问题,
// 现在只能实时从`EMAccount`里面去读了
//

@implementation EMWebAppInfo


+ (instancetype)shareWebAppInfo {
    static EMWebAppInfo *appWebInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appWebInfo = [[self alloc] init];
    });
    return appWebInfo;
}

- (NSDictionary *)appExtraInfo {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    EMWebAppInfo *webAppInfo = [EMWebAppInfo shareWebAppInfo];
    webAppInfo.productID = @([EMAppSettings appSettings].productID);
    webAppInfo.platformID = @([EMAppSettings appSettings].platformID);
    webAppInfo.version = [UIApplication sharedApplication].versionDescription;
    webAppInfo.vendorID = @([EMAppSettings appSettings].vendorID);
    
    webAppInfo.guid = [UIDevice currentDevice].uniqueGlobalDeviceIdentifier;
    webAppInfo.systemVersion = [UIDevice currentDevice].systemVersion;
    
    webAppInfo.loginType = @([EMAccount sharedAccount].loginType);
    
    webAppInfo.userID = [EMAccount sharedAccount].userID;
    
    webAppInfo.webAuthToken = [EMAccount sharedAccount].webAuthToken;

    parameters[@"pd"] = self.productID;
    parameters[@"ar"] = self.platformID;
    parameters[@"mv"] = self.version;
    parameters[@"vd"] = self.vendorID;
    
    parameters[@"guid"] = self.guid;
    parameters[@"systemVersion"] = self.systemVersion;
    
    parameters[@"loginType"] = self.loginType;
    
    if (self.userID) {
        parameters[@"userId"] = self.userID;
    }
    
    if (self.webAuthToken) {
        parameters[@"webAuthToken"] = self.webAuthToken;
    }
    
    return parameters;
}

@end

@implementation EMWebAppInfo (EMStock)

- (void)updateWebAppInfo {
    EMWebAppInfo *webAppInfo = [EMWebAppInfo shareWebAppInfo];
    webAppInfo.productID = @([EMAppSettings appSettings].productID);
    webAppInfo.platformID = @([EMAppSettings appSettings].platformID);
    webAppInfo.version = [UIApplication sharedApplication].versionDescription;
    webAppInfo.vendorID = @([EMAppSettings appSettings].vendorID);
    
    webAppInfo.guid = [UIDevice currentDevice].uniqueGlobalDeviceIdentifier;
    webAppInfo.systemVersion = [UIDevice currentDevice].systemVersion;
    
    webAppInfo.loginType = @([EMAccount sharedAccount].loginType);
    
    webAppInfo.userID = [EMAccount sharedAccount].userID;
    
    webAppInfo.webAuthToken = [EMAccount sharedAccount].webAuthToken;
}

@end
