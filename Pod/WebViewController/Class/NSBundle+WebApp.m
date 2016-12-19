//
//  NSBundle+WebApp.m
//  Pods
//
//  Created by ryan on 07/12/2016.
//
//

#import "NSBundle+WebApp.h"

static NSString *const kDefaultWebAppImageResouceBundle = @"WebAppImageResouceBundle";

@interface EMWebAppDummy : NSObject
@end

@implementation EMWebAppDummy
@end


static NSBundle *webAppImageResouceBundle = nil;
static NSBundle *overrideWebAppImageResouceBundle = nil;

@implementation NSBundle (WebApp)


+ (instancetype)webAppBundle {
    return [NSBundle bundleForClass:[EMWebAppDummy class]];
}

+ (instancetype)webAppImageResouceBundle {
    if (webAppImageResouceBundle == nil) {
        NSString *path = [[NSBundle webAppBundle] pathForResource:kDefaultWebAppImageResouceBundle ofType:@"bundle"];
        webAppImageResouceBundle = [NSBundle bundleWithPath:path];
    }
    return webAppImageResouceBundle;
}

+ (void)setWebAppImageResouceBundle:(NSBundle *)bundle {
    webAppImageResouceBundle = bundle;
}

+ (void)setOverrideWebAppImageResouceBundle:(NSBundle *)bundle {
    overrideWebAppImageResouceBundle = bundle;
}

+ (instancetype)overrideWebAppImageResouceBundle {
    return overrideWebAppImageResouceBundle;
}


@end
