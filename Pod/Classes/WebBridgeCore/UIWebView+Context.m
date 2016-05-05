//
//  UIWebView+Context.m
//  Pods
//
//  Created by ryan on 4/27/16.
//
//

#import "UIWebView+Context.h"

@implementation UIWebView (Context)

- (JSContext *)javaScriptContext {
    return [self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
}

@end
