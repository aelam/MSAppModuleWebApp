//
//  JSBridgeModuleEMStock.m
//  Pods
//
//  Created by ryan on 16/12/2016.
//
//

#import "JSBridgeModuleEMStock.h"
#import "JSBridge.h"
#import "MSAppSettingsWebApp.h"
#import "EMWebViewController.h"
#import "BDKNotifyHUD.h"
#import "JSBridgeModule.h"
#import <JLRoutes/JLRoutes.h>
#import "MSCustomMenuItem.h"

@implementation JSBridgeModuleEMStock

@synthesize bridge = _bridge;

JS_EXPORT_MODULE();

- (NSUInteger)priority {
    return JSBridgeModulePriorityNormal;
}

- (NSString *)moduleSourceFile {
    return [[NSBundle bundleForClass:[self class]] pathForResource:@"EMJSBridgeEMStock" ofType:@"js"];
}

- (void)attachToJSBridge:(JSBridge *)bridge {
    [self registerCanOpenURL2WithBridge:bridge];
    [self registerOpenPageWithBridge:bridge];
    [self registerRoutePageWithBridge:bridge];
    [self registerLoginWithBridge:bridge];
    
    [self registerSearchWithBridge:bridge];
    [self registerUpdateUserInfoWithBridge:bridge];
}

#pragma mark - JLRoutes跳转
// page
- (void)registerOpenPageWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"page"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"page" handler:handler];
    
}

- (void)registerRoutePageWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"page"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"routePage" handler:handler];
    
}

- (void)registerCheckTaskStatusWithBridge:(JSBridge *)bridge {
    [self registerHandler:@"checkTaskStatus" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"checkTaskStatus"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    }];
}

- (void)registerLoginWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"login"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"login" handler:handler];
}

- (void)registerUpdateUserInfoWithBridge:(JSBridge *)bridge {
    //    __typeof(self)weakSelf = self;
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"updateUserInfo"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"updateUserInfo" handler:handler];
}

// 移到search
- (void)registerSearchWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"search"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"search" handler:handler];
}

- (void)registerCanOpenURL2WithBridge:(JSBridge *)bridge {
    // 旧版canOpenURL支持回调方式
    // callback按照老的返回值传回去
    [self registerHandler:@"canOpenURL" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *parameters = (NSDictionary *)data;
        if (![parameters isKindOfClass:[NSDictionary class]]) {
            // 特殊
            responseCallback(@(0));
            return;
        }
        
        NSString *url = parameters[@"appurl"];
        if ([url isKindOfClass:[NSNull class]]) {
            url = @"";
        }
        
        NSInteger canopen = (NSInteger )[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
        responseCallback(@(canopen));
    }];
    
    
    [self registerHandler:@"canOpenURL2" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *parameters = (NSDictionary *)data;
        if (![parameters isKindOfClass:[NSDictionary class]]) {
            // 特殊
            responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeFailed),
                               JSResponseErrorDataKey:@(NO)});
            return;
        }
        NSString *url = parameters[@"appurl"];
        
        BOOL canopen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess),
                           JSResponseErrorDataKey:@(canopen)});
    }];
}


@end

