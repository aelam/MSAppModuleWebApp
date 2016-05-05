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
    JSContext *context = nil;
    __weak __typeof (self)weakSelf = self;
    __weak JSBridge *weakBridge = bridge;
    
    JSValue *goods = [context objectForKeyedSubscript:@"goods"];
    
    BOOL (^CanOpenURL)(NSString *, NSString *) = ^BOOL(NSString *urlString, NSString *callback) {
        BOOL rs = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]];
        NSString* string = [NSString stringWithFormat:@"%@(%d);",callback,rs];
        [weakBridge.webView stringByEvaluatingJavaScriptFromString:string];
        
        return rs;
    };
    
    [goods setObject:CanOpenURL forKeyedSubscript:@"canOpenURL"];
    
    id<MSAppSettingsWebApp> settings = (id<MSAppSettingsWebApp>)[MSAppSettings appSettings];
    
#if 1
//    //
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
        return [[MSWebAppInfo getWebAppInfoWithSettings:settings] jsonString];
    };
    [goods setObject:getAppInfo forKeyedSubscript:@"getAppInfo"];
#endif

    
}

@end
