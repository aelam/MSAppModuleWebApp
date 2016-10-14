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
#import <UIViewController+Routes.h>
#import "EMWebViewController.h"
#import "JLRoutes+WebApp.h"

@implementation MSAppModuleWebApp

- (void)moduleDidLoad:(id<MSAppSettingsWebApp>)info {
    [super moduleDidLoad:info];
    
    NSAssert([[info supportsURLSchemes] count] >= 1, @"需要配置`supportsURLSchemes`");
    NSAssert([info mainURLScheme], @"需要配置`mainURLScheme`");
    NSAssert([info userHasZXGHandler], @"需要配置`userHasZXGHandler`");

}

- (void)moduleDidUnload:(id<MSAppSettings>)info {
    [super moduleDidUnload:info];
}

- (void)moduleRegisterRoutes:(JLRoutes *)route {
    [route registerRoutesForWebApp];
}

- (void)moduleUnregisterRoutes:(JLRoutes *)route {
//    [route registerRoutesForWebApp];
}

@end
