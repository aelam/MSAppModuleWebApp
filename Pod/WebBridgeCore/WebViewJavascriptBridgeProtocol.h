//
//  WebViewJavascriptBridgeProtocol.h
//  Pods
//
//  Created by Ryan Wang on 16/5/7.
//
//

#if __has_include(<WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>)
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#else
@import WebViewJavascriptBridge;
#endif

@protocol WebViewJavascriptBridgeProtocol <NSObject>

+ (instancetype)bridgeForWebView:(id)webView;
+ (void)enableLogging;
+ (void)setLogMaxLength:(int)length;

- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler;
- (void)callHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(id)data;
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback;
- (void)setWebViewDelegate:(id)webViewDelegate;

@end

@interface WebViewJavascriptBridge (Protocol) <WebViewJavascriptBridgeProtocol>

@end

@interface WKWebViewJavascriptBridge (Protocol) <WebViewJavascriptBridgeProtocol>

@end
