//
//  UIWebView+TS_JavaScriptContext.h
//  testJSWebView
//
//  Created by Nicholas Hodapp on 11/15/13.
//  Copyright (c) 2013 CoDeveloper, LLC. All rights reserved.
//
//  https://github.com/TomSwift/UIWebView-TS_JavaScriptContext
//  https://github.com/liaojinxing/HybridBridge


#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TSWebViewDelegate <UIWebViewDelegate>

@optional

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext*) ctx;

@end


@interface UIWebView (TS_JavaScriptContext)

@property (nonatomic, readonly) JSContext* ts_javaScriptContext;

@end
