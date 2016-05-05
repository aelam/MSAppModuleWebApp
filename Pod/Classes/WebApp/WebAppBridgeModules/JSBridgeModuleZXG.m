//
//  JSBridgeModuleZXG.m
//  Pods
//
//  Created by ryan on 5/5/16.
//
//

#import "JSBridgeModuleZXG.h"
#import <JLRoutes/JLRoutes.h>

@implementation JSBridgeModuleZXG

JS_EXPORT_MODULE();

- (void)attachToJSBridge:(JSBridge *)bridge {
    [self registerAddZXGWithBridge:bridge];
}

// addZXG
- (void)registerAddZXGWithBridge:(JSBridge *)bridge {
    __typeof(self)weakSelf = self;
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"addZXG"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"addZXG" handler:handler];
}



@end
