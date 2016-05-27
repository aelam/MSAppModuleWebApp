//
//  UIWebView+XWebView.m
//  Pods
//
//  Created by Ryan Wang on 16/5/8.
//
//

#import "UIWebView+XWebView.h"

@implementation UIWebView (XWebView)

- (void)x_loadRequest:(NSURLRequest *)request {
    [self loadRequest:request];
}

- (void)x_loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL {
    [self loadHTMLString:string baseURL:baseURL];
}

- (void)x_evaluateJavaScript:(NSString *)javaScriptString {
    [self stringByEvaluatingJavaScriptFromString:javaScriptString];
}

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ __nullable)(__nullable id, NSError * __nullable error))completionHandler {
    NSString *rs = [self stringByEvaluatingJavaScriptFromString:javaScriptString];
    if (completionHandler) {
        completionHandler(rs, NULL);
    }
}


- (id)UIDelegate {
    return self.delegate;
}

- (void)setUIDelegate:(id)UIDelegate {
    self.delegate = UIDelegate;
}

- (NSURL *)URL {
    return self.request.mainDocumentURL;
}

- (void)x_reload {
    [self reload];
}

- (void)x_stopLoading {
    [self stopLoading];
}

- (void)x_goBack {
    [self goBack];
}

- (void)x_goForward {
    [self goForward];
}


@end
