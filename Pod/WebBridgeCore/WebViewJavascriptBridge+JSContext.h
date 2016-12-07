//
//  WebViewJavascriptBridge+JSContext.h
//  Pods
//
//  Created by ryan on 5/6/16.
//
//

//#if __has_include(<WebViewJavascriptBridge/WebViewJavascriptBridge.h>)
//#else
//#endif

//#import "WebViewJavascriptBridge.h"
//#import "WKWebViewJavascriptBridge.h"

// 查找_webViewDelegate 并转发`-[delegate webView:didCreateJavaScriptContext:]`
#import <WebViewJavascriptBridge/WebViewJavascriptBridgeBase.h>

@interface WebViewJavascriptBridgeBase (JSContext)

@end
