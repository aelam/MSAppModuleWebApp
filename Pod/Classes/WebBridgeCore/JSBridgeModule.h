//
//  JSModule.h
//  Pods
//
//  Created by ryan on 4/25/16.
//
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSDefines.h"
#import <WebViewJavaScriptBridge/WebViewJavaScriptBridge.h>

typedef NS_ENUM(NSInteger, JSResponseErrorCode)  {
    JSResponseErrorCodeSuccess  = 0,
    JSResponseErrorCodeCancelled= -1,
    JSResponseErrorCodeFailed   = -2
};

typedef NS_ENUM(NSInteger, JSBridgeModulePriority)  {
    JSBridgeModulePriorityHigh  = 1000,
    JSBridgeModulePriorityNormal= 500,
    JSBridgeModulePriorityLow   = 0
};



extern NSString * const JSResponseErrorCodeKey;
extern NSString * const JSResponseErrorMessageKey;
extern NSString * const JSResponseErrorDataKey;


@class JSBridge;

@protocol JSBridgeModule <NSObject>


#define JS_EXPORT_MODULE(js_name) \
JS_EXTERN void JSRegisterModule(Class); \
+ (NSString *)moduleName { return @#js_name; } \
+ (void)load { JSRegisterModule(self); }

+ (NSString *)moduleName;
- (NSString *)moduleSourceFile;
- (NSUInteger)priority;

- (void)attachToJSBridge:(JSBridge *)bridge;

@optional

/**
 * A reference to the RCTBridge. Useful for modules that require access
 * to bridge features, such as sending events or making JS calls. This
 * will be set automatically by the bridge when it initializes the module.
 * To implement this in your module, just add `@synthesize bridge = _bridge;`
 */
@property (nonatomic, weak, readonly) JSBridge *bridge;

// 通过注册WebViewJavaScriptBridge注册方法
- (void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)handler;
- (NSDictionary *)messageHandlers;

// 通过注册JSContext注册方法
- (void)registerHandler:(NSString *)handlerName JSContextHandler:(JSValue *)handler;
- (NSDictionary *)JSContextMessageHandlers;


@end


@interface JSBridgeModule : NSObject <JSBridgeModule>

@end