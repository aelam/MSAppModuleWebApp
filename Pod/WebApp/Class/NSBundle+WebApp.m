//
//  NSBundle+WebApp.m
//  Pods
//
//  Created by ryan on 07/12/2016.
//
//

#import "NSBundle+WebApp.h"

@interface EMWebAppDummy : NSObject
@end

@implementation EMWebAppDummy
@end


static NSBundle *webAppResourceBundle = nil;

@implementation NSBundle (WebApp)


+ (instancetype)webAppBundle {
    return [NSBundle bundleForClass:[EMWebAppDummy class]];
}

+ (instancetype)webAppResourceBundle {
    if (webAppResourceBundle == nil) {
        webAppResourceBundle = [NSBundle bundleForClass:[EMWebAppDummy class]];
    }
    return webAppResourceBundle;
}

+ (void)setWebAppResourceBundle:(NSBundle *)bundle {
    webAppResourceBundle = bundle;
}

@end
