//
//  UIApplication+AppVersion.m
//  EMSpeed
//
//  Created by ryan on 16/1/14.
//
//

#import "UIApplication+AppVersion.h"
#import "MSUIKitCoreFunction.h"

static _MSAppVersion kAppVersion;

static inline void loadAppVersionStruct() {
    
    NSInteger majorVersion = 0;
    NSInteger minorVersion = 0;
    NSInteger buildNumber  = 0;
    
    NSString *versionText = MSAppVersion();
    NSArray *verArr = [versionText componentsSeparatedByString:@"."];
    if ([verArr count] > 2) {
        majorVersion = [verArr[0] intValue];
        minorVersion = [verArr[1] intValue];
        buildNumber = [verArr[2] intValue];
    }
    else if ([verArr count] > 1) {
        majorVersion = [verArr[0] intValue];
        minorVersion = [verArr[1] intValue];
        buildNumber = 0;
    }
    else if ([verArr count] == 1){
        majorVersion = [verArr[0] intValue];
        minorVersion = 0;
        buildNumber = 0;
    }
    
    kAppVersion.majorVersion = majorVersion;
    kAppVersion.minorVersion = minorVersion;
    kAppVersion.patchVersion = buildNumber;
}


@implementation UIApplication (AppVersion)

+ (void)load {
    loadAppVersionStruct();
}

- (_MSAppVersion)appVersion {
    return kAppVersion;
}

- (NSInteger)majorVersion {
    return kAppVersion.majorVersion;
}


- (NSInteger)minorVersion {
    return kAppVersion.minorVersion;
}

- (NSInteger)patchVersion {
    return kAppVersion.patchVersion;
}

- (NSString *)versionDescription {
    return [NSString stringWithFormat:@"%zd.%zd.%zd", kAppVersion.majorVersion, kAppVersion.minorVersion, kAppVersion.patchVersion];
}

- (NSInteger)versionIntVal {
    return kAppVersion.majorVersion * 10000 + kAppVersion.minorVersion * 100 + kAppVersion.patchVersion;
}

@end
