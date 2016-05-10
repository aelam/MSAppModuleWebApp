//
//  JSBridgeModuleZXG.m
//  Pods
//
//  Created by ryan on 5/5/16.
//
//

#import "JSBridgeModuleZXG.h"
#import <JLRoutes/JLRoutes.h>
#import "JSBridge.h"
#import "UIWebView+TS_JavaScriptContext.h"

extern BOOL User_hasStockAtZXG(NSInteger);

@implementation JSBridgeModuleZXG

JS_EXPORT_MODULE();

- (void)attachToJSBridge:(JSBridge *)bridge {
    [self registerAddZXGWithBridge:bridge];
    [self registerIsZXGWithBridge:bridge];
}

// addZXG ~2.8.5
- (void)registerAddZXGWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"addZXG"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"addZXG" handler:handler];
}

// IsZXG
- (void)registerIsZXGWithBridge:(JSBridge *)bridge {
    UIWebView *webView = bridge.webView;
    if (![webView isKindOfClass:[UIWebView class]]) {
        return;
    }

    JSContext *context = bridge.javascriptContext;
    JSValue *goods = [context objectForKeyedSubscript:@"goods"];

    __weak JSBridge *weakBridge = bridge;

    BOOL (^IsZxg)(NSString *, NSString *callback) = ^BOOL(NSString *stockId, NSString *callback) {
        if (&User_hasStockAtZXG) {
            NSInteger goodsId = [stockId integerValue];
            BOOL isZXG = User_hasStockAtZXG(goodsId);
            NSString* string = [NSString stringWithFormat:@"%@(%d);",callback,isZXG];
            [weakBridge.webView evaluateJavaScript:string completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                
            }];
            return isZXG;
        } else {
            return NO;
        }
    };
    [goods setObject:IsZxg forKeyedSubscript:@"isZxg"];

//    [self registerHandler:@"goods.isZxg" JSContextHandler:(id)IsZxg];
}

@end
