//
//  WebViewJavascriptBridgeProtocol.h
//  Pods
//
//  Created by Ryan Wang on 16/5/7.
//
//

#import <Foundation/Foundation.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>

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
