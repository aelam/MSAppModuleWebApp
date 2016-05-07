//
//  JSBridgeModuleJSContext.m
//  Pods
//
//  Created by ryan on 5/5/16.
//
//

#import "JSBridgeModuleJSContext.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MSAppSettings.h"
#import "NSDictionary+JSONString.h"
#import "MSWebAppInfo.h"
#import "JSBridge.h"

@implementation JSBridgeModuleJSContext

JS_EXPORT_MODULE();

- (void)attachToJSBridge:(JSBridge *)bridge {
    JSContext *context = bridge.javascriptContext;
//    __weak __typeof (self)weakSelf = self;
    __weak JSBridge *weakBridge = bridge;
    
    JSValue *goods = [context objectForKeyedSubscript:@"goods"];
    
    BOOL (^CanOpenURL)(NSString *, NSString *) = ^BOOL(NSString *urlString, NSString *callback) {
        BOOL rs = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]];
        NSString* string = [NSString stringWithFormat:@"%@(%d);",callback,rs];
        [weakBridge.webView x_evaluateJavaScript:@"console.log(\"2.9.0使用canOpenURL2({appurl:xxx},function(info){})\")"];
        [weakBridge.webView evaluateJavaScript:string completionHandler:NULL];

        return rs;
    };
    
    [goods setObject:CanOpenURL forKeyedSubscript:@"canOpenURL"];
    
    id<MSAppSettingsWebApp> settings = (id<MSAppSettingsWebApp>)[MSAppSettings appSettings];

#warning 实现自选股JS
#if 1
    //
//    BOOL (^IsZxg)(NSString *, NSString *callback) = ^BOOL(NSString *stockId, NSString *callback) {
//        if (&User_hasStockAtZXG) {
//            NSInteger goodsId = [stockId integerValue];
////            BOOL isZXG = User_hasStockAtZXG(goodsId);
//            NSString* string = [NSString stringWithFormat:@"%@(%d);",callback,isZXG];
////            [weakSelf stringByEvaluatingJavaScriptFromString:string];
//            return isZXG;
//        } else {
//            return NO;
//        }
//    };
//    [goods setObject:IsZxg forKeyedSubscript:@"isZxg"];
    
    //
    NSString *(^getAppInfo)() = ^NSString * () {
        [weakBridge.webView x_evaluateJavaScript:@"console.log(\"2.9.0使用getAppInfo2(null,function(info){})\")"];

        return [[MSWebAppInfo getWebAppInfoWithSettings:settings] jsonString];
    };
    [goods setObject:getAppInfo forKeyedSubscript:@"getAppInfo"];
#endif

    
}

@end
