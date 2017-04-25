//
//  JLRoutes+WebApp.h
//  Pods
//
//  Created by ryan on 3/17/16.
//
//

#import <JLRoutes/JLRoutes.h>
#import <MSAppModuleKit/MSAppModuleKit.h>

@interface JLRoutes (WebApp)

- (void)registerWebRoutesWithAppSettings:(id<MSAppSettings>)settings;
- (void)unregisterWebRoutesWithAppSettings:(id<MSAppSettings>)settings;

@end
