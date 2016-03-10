//
//  NSURL+AuthedURL.m
//  Pods
//
//  Created by ryan on 3/10/16.
//
//

#import "NSURL+AuthedURL.h"
#import "MSAppModuleWebApp.h"
#import "MSWebAppInfo.h"
#import <EMSpeed/MSCore.h>

@implementation NSURL (AuthedURL)

+ (NSURL *)authedURLWithURL:(NSURL *)plainURL {
    
    MSAppModuleWebApp *webApp = [appModuleManager appModuleWithModuleName:NSStringFromClass([MSAppModuleWebApp class])];
    id<MSAppSettingsWebApp> settings = (id<MSAppSettingsWebApp>)[webApp moduleSettings];
    NSDictionary *authInfo = [MSWebAppInfo getWebAppInfoWithSettings:settings];
    
    NSString *urlString = [[plainURL absoluteString] stringByAppendingParameters:authInfo];
    
    if ([settings.theme isEqualToString:@"black"]) {
        urlString = [urlString stringByAppendingString:@"&css=b"];
        
        NSRange range = [urlString rangeOfString: @"platform/html/"];
        if (range.location != NSNotFound)
        {
            urlString = [urlString stringByReplacingOccurrencesOfString: @"platform/html/" withString: @"platform/blackhtml/"];
        }
    }
    
    NSURL *authedURL = [NSURL URLWithString:urlString];
    
    return authedURL;
}

@end
