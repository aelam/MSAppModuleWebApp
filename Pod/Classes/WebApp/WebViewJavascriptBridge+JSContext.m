//
//  WebViewJavascriptBridge+JSContext.m
//  Pods
//
//  Created by ryan on 5/6/16.
//
//

#import "WebViewJavascriptBridge+JSContext.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <objc/runtime.h>

@implementation WebViewJavascriptBridge (JSContext)

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)ctx
{
    Ivar ivar = class_getInstanceVariable([self class], [@"_webViewDelegate" UTF8String]);
    id delegate = object_getIvar(self, ivar);
    if ([delegate respondsToSelector:_cmd]) {
        [delegate webView:webView didCreateJavaScriptContext:ctx];
    }
    
}

@end
