//
//  JSBridgeModuleJSContext.m
//  Pods
//
//  Created by ryan on 5/5/16.
//
//

#import "JSBridgeModuleJSContext.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <MSAppModuleKit/MSAppModuleKit.h>
#import "MSAppSettingsWebApp.h"
#import <EMSpeed/MSCore.h>
#import "JSBridge.h"
#import "UIWebView+TS_JavaScriptContext.h"

@implementation JSBridgeModuleJSContext

JS_EXPORT_MODULE();

- (NSUInteger)priority {
    return JSBridgeModulePriorityLow;
}

- (void)attachToJSBridge:(JSBridge *)bridge {
    UIWebView *webView = (UIWebView <XWebView> *)bridge.webView;
    if (![webView isKindOfClass:[UIWebView class]]) {
        return;
    }
    
    JSContext *context = bridge.javascriptContext;
    __weak JSBridge *weakBridge = bridge;
    
    JSValue *goods = [context objectForKeyedSubscript:@"goods"];
    
    BOOL (^CanOpenURL)(NSString *, NSString *) = ^BOOL(NSString *urlString, NSString *callback) {
        BOOL rs = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]];
        NSString* string = [NSString stringWithFormat:@"%@(%d);",callback,rs];
        [weakBridge.webView x_evaluateJavaScript:@"console.log(\"WARN:2.9.0以上使用canOpenURL2({appurl:xxx},function(info){})\")"];
        [weakBridge.webView evaluateJavaScript:string completionHandler:^(id result, NSError * _Nullable error) {
            
        }];

        return rs;
    };
    
    [goods setObject:CanOpenURL forKeyedSubscript:@"canOpenURL"];
    
    
    [self registerHandler:@"canOpenURL" JSContextHandler:(id)CanOpenURL];
    
    id<MSAppSettingsWebApp> settings = (id<MSAppSettingsWebApp>)[MSAppSettings appSettings];

    //
    NSString *(^getAppInfo)() = ^NSString * () {
        [weakBridge.webView x_evaluateJavaScript:@"console.log(\"WARN:2.9.0以上使用getAppInfo2(null,function(info){})\")"];
        if (settings.webAppAuthInfo) {
            return [settings.webAppAuthInfo() jsonString];
        }
        return nil;
    };
    [goods setObject:getAppInfo forKeyedSubscript:@"getAppInfo"];
    
    [self registerHandler:@"getAppInfo" JSContextHandler:(id)getAppInfo];


    
}

@end
