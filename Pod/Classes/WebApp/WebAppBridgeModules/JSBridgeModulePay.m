//
//  JSBridgeModulePay.m
//  Pods
//
//  Created by ryan on 5/9/16.
//
//

#import "JSBridgeModulePay.h"
#import <JLRoutes/JLRoutes.h>
#import "JSBridge.h"

@implementation JSBridgeModulePay

JS_EXPORT_MODULE();

- (void)attachToJSBridge:(JSBridge *)bridge {
    [self registerPayWithBridge:bridge];
}

- (void)registerPayWithBridge:(JSBridge *)bridge {
    [self registerHandler:@"pay" handler:^(id data, WVJBResponseCallback responseCallback) {
        // SDK
        
        NSDictionary *info = @{};
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess),
                           JSResponseErrorDataKey:info});
    }];
}

@end
