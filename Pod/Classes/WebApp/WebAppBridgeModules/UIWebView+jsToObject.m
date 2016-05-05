//
//  UIWebView+jsToObject.m
//  ymActionWebView
//
//  Created by flora on 14-7-4.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "UIWebView+jsToObject.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <EMSpeed/MSCore.h>

#define kJSBridgeFileName @"EMJSBridge.js"

@implementation UIWebView (jsToObject)

- (void)loadActionJavaScript
{
    JSContext *context = [self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    JSValue *goods = [context objectForKeyedSubscript:@"goods"];
    if ([goods toDictionary]) {
        return;
    }
    
    static NSString *g_jsString = nil;
    if (g_jsString == nil)
    {
        NSString *path = MSPathForBundleResource([NSBundle mainBundle], kJSBridgeFileName);
        NSError *error = nil;
        g_jsString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    }
    
    [context evaluateScript:g_jsString];
}


@end
