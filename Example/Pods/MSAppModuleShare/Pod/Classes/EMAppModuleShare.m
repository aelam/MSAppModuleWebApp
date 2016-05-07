//
//  EMAppModuleShare.m
//  Pods
//
//  Created by ryan on 16/1/8.
//
//

#import "EMAppModuleShare.h"
#import "EMAppShareSettings.h"
#import "EMSocialSDK.h"
#import "EMShareEntity.h"

@implementation EMAppModuleShare

- (void)moduleDidLoad:(id<EMAppShareSettings>)info {
    [super moduleDidLoad:info];
    
    NSAssert(info.shareConfigurator, @"setting.shareConfigurator shouldn't be nil");
    NSAssert(info.productID, @"setting.productID shouldn't be nil");
    
    [EMSocialSDK sharedSDKWithConfigurator:info.shareConfigurator];
    [[EMSocialSDK sharedSDK] registerBuiltInSocialApps];
    [EMShareEntity setDefaultURLParameters:@{@"productId": @(info.productID)}];
    
    [self updateShareThemeWithInfo:info];
    
    [(NSObject *)self.moduleSettings addObserver:self forKeyPath:@"theme" options:NSKeyValueObservingOptionNew context:NULL];
    
}

- (void)moduleDidUnload:(id<EMAppShareSettings>)info {
    [super moduleDidUnload:info];
    
    [(NSObject *)self.moduleSettings removeObserver:self forKeyPath:@"theme"];
}

- (BOOL)openURL:(NSURL *)arg1 sourceApplication:(NSString *)app annotation:(id)annotation navigation:(id)arg4 {
    return [[EMSocialSDK sharedSDK] handleOpenURL:arg1 sourceApplication:app];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"theme"]) {
        [self updateShareThemeWithInfo:(id<EMAppShareSettings>)self.moduleSettings];
    }
}

- (void)updateShareThemeWithInfo:(id<EMAppShareSettings>)info {
    NSString *theme = [info theme];
    if ([theme isEqualToString:@"black"]) {
        [EMSocialSDK sharedSDK].activityStyle = EMActivityStyleBlack;
    } else {
        [EMSocialSDK sharedSDK].activityStyle = EMActivityStyleWhite;
    }
    
}

@end
