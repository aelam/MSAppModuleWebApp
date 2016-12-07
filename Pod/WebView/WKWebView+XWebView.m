//
//  WKWebView+XWebView.m
//  Pods
//
//  Created by Ryan Wang on 16/5/8.
//
//

#import "WKWebView+XWebView.h"

@implementation WKWebView (XWebView)

- (void)x_loadRequest:(NSURLRequest *)request {
    [self loadRequest:request];
}

- (void)x_loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL {
    [self loadHTMLString:string baseURL:baseURL];
}

- (void)x_evaluateJavaScript:(NSString *)javaScriptString {
    [self evaluateJavaScript:javaScriptString completionHandler:^(id _Nullable rs, NSError * _Nullable error) {
    }];
}

- (void)x_reload {
    [self reload];
}

- (void)x_goBack {
    [self goBack];
}

- (void)x_goForward {
    [self goForward];
}

@end
