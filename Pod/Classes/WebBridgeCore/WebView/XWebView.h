//
//  XWebView.h
//  Pods
//
//  Created by Ryan Wang on 16/5/8.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XWebView <NSObject>

// UIWebView, WKWebView实现相同的方法
@property (nonatomic, readonly, strong) UIScrollView *scrollView NS_AVAILABLE_IOS(5_0);

- (BOOL)canGoBack;
- (BOOL)canGoForward;
- (BOOL)isLoading;
- (void)stopLoading;

// UIWebView未实现部分
// 映射到delegate
- (id)UIDelegate;
- (void)setUIDelegate:(nullable id)UIDelegate;
// -[UIWebView request].mainDocumentURL
- (NSURL *)URL;

// UIWebView的completionHandler的error永远为空, 成功的结果是执行-stringByEvaluatingJavaScriptFromString的字符串返回
- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ __nullable)(__nullable id, NSError * __nullable error))completionHandler;

// UIWebView, WKWebView实现有差异的方法
- (void)x_loadRequest:(NSURLRequest *)request;
- (void)x_loadHTMLString:(NSString *)string baseURL:(nullable NSURL *)baseURL;
- (void)x_evaluateJavaScript:(NSString *)javaScriptString;


- (void)x_reload;

- (void)x_goBack;
- (void)x_goForward;

@end

NS_ASSUME_NONNULL_END