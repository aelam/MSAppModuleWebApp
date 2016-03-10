//
//  MSWebAppInfo.m
//  Pods
//
//  Created by ryan on 3/9/16.
//
//

#import "MSWebAppInfo.h"
#import <EMSpeed/MSUIKitCore.h>

@implementation MSWebAppInfo

+ (NSDictionary *)getWebAppInfoWithSettings:(id<MSAppSettingsWebApp>)appSettings {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"pd"] = @(appSettings.productID);
    parameters[@"ar"] = @(appSettings.platformID);
    parameters[@"mv"] = [UIApplication sharedApplication].versionDescription;
    parameters[@"vd"] = @(appSettings.vendorID);
    
    parameters[@"guid"] = [UIDevice currentDevice].uniqueGlobalDeviceIdentifier;
    parameters[@"systemVersion"] = [UIDevice currentDevice].systemVersion;

    if(appSettings.webAppAuthInfo) {
        NSDictionary *extraInfo = appSettings.webAppAuthInfo();
        [parameters addEntriesFromDictionary:extraInfo];
    }

    return parameters;

}

@end
