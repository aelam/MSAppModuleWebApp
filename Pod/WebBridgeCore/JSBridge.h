//
//  JSBridgeManager.h
//  Pods
//
//  Created by ryan on 4/25/16.
//
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
#import "JSDefines.h"
#import "WebViewJavascriptBridgeProtocol.h"
#import "XWebView.h"

#if __has_include(<WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>)
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#else
@import WebViewJavascriptBridge;
#endif


@protocol WebView <NSObject>

- (id<WebView>)webView;

@end

JS_EXTERN void JSRegisterModule(Class);
JS_EXTERN NSArray<Class> *JSGetModuleClasses(void);

@protocol JSBridgeModule;


@interface JSBridge : NSObject

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) UIView <XWebView>*webView;
@property (nonatomic, weak) id<WebViewJavascriptBridgeProtocol> javaScriptBridge;
@property (nonatomic, weak) JSContext *javascriptContext;

- (NSArray *)modules;
- (id<JSBridgeModule>)moduleForName:(NSString *)moduleName;
- (id<JSBridgeModule>)moduleForClass:(Class)moduleClass;

+ (instancetype)currentBridge;
+ (void)setCurrentBridge:(JSBridge *)bridge;
+ (instancetype)sharedBridge;

- (void)attachToBridge:(id <WebViewJavascriptBridgeProtocol>)bridge;

- (void)reset;

@end
