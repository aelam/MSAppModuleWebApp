//
//  JSBridgeModuleAudioPlay.m
//  Pods
//
//  Created by ryan on 5/9/16.
//
//

#import "JSBridgeModuleAudioPlay.h"
#import <JLRoutes/JLRoutes.h>
#import "JSBridge.h"

@implementation JSBridgeModuleAudioPlay

JS_EXPORT_MODULE();

- (NSString *)moduleSourceFile {
    return [[NSBundle bundleForClass:[self class]] pathForResource:@"EMJSBridgeAudioPlay" ofType:@"js"];
}

- (void)attachToJSBridge:(JSBridge *)bridge {
    [self registerAudioPlayWithBridge:bridge];
}

//2.9.0
- (void)registerAudioPlayWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"playAudio" handler:handler];
}

- (void)registerAudioStopWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"stopAudio" handler:handler];
}

@end
