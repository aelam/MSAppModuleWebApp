//
//  JSBridgeManager.h
//  Pods
//
//  Created by ryan on 4/25/16.
//
//

#import <Foundation/Foundation.h>
#import <WebViewJavaScriptBridge/WebViewJavaScriptBridge.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
#import "JSDefines.h"

@protocol WebView <NSObject>

- (id<WebView>)webView;

@end


JS_EXTERN NSArray<Class> *JSGetModuleClasses(void);

@protocol JSBridgeModule;


@interface JSBridge : NSObject

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) WKWebView *wkWebView;
@property (nonatomic, weak) WebViewJavascriptBridge *javaScriptBridge;
@property (nonatomic, weak) JSContext *javascriptContext;

- (NSArray *)modules;
- (id<JSBridgeModule>)moduleForName:(NSString *)moduleName;
- (id<JSBridgeModule>)moduleForClass:(Class)moduleClass;

+ (instancetype)currentBridge;
+ (void)setCurrentBridge:(JSBridge *)bridge;
+ (instancetype)sharedBridge;

- (void)attachToBridge:(WebViewJavascriptBridge *)bridge;


@end
