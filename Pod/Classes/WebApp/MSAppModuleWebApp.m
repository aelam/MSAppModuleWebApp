//
//  MSAppModuleWebApp.m
//  Pods
//
//  Created by ryan on 3/9/16.
//
//

#import "MSAppModuleWebApp.h"
#import "MSAppSettingsWebApp.h"
#import <JLRoutes/JLRoutes.h>

@implementation MSAppModuleWebApp

- (void)moduleDidLoad:(id<MSAppSettingsWebApp>)info {
    [super moduleDidLoad:info];
    
    NSAssert([[info supportsURLSchemes] count] >= 1, @"需要配置`supportsURLSchemes`");
}

- (void)moduleDidUnload:(id<MSAppSettings>)info {
    [super moduleDidUnload:info];
}

@end
