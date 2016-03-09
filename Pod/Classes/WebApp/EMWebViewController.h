//
//  ymActionWebViewController.h
//  ymActionWebView
//
//  Created by flora on 14-7-3.
//  Copyright (c) 2014年 flora. All rights reserved.
//
//
//1、加载网页
//2、可通过设置synchronizeDocumentTitle = yes，同步在导航栏显示当前页面的标题，默认是yes
//3、可通过各接口加载url、request、htmlstring
//4、支持js事件
//5、处理tel以及sms事件
//6、自定义返回控件，可控制页面内返回事件。用户点击返回按键执行网页后退一次后，增加关闭按键，可通过关闭按键退出当前controller
//

#import <UIKit/UIKit.h>
#import "UIViewController+Routes.h"
#import "UIViewController+EMShare.h"
#import "UIViewController+SearchStock.h"

@class EMWebBackView;
@class EMShareEntity;
@protocol UIViewControllerRouter;


@interface EMWebViewController : UIViewController<UIWebViewDelegate, UIViewControllerRouter, UIViewControllerShareSupport, UIViewControllerSearchSupport>
{
@protected
    UIWebView *_webView;
}

@property (nonatomic, assign) BOOL synchronizeDocumentTitle;//navbar同步页面document的title，default is yes

@property (nonatomic, strong, readonly) UIWebView *webView;
@property (nonatomic, assign,getter=isCloseButtonShown) BOOL showsCloseButton; // Default YES

// Share Supports
@property (nonatomic, strong) EMShareEntity *shareEntity;
@property (nonatomic, assign) BOOL isShareItemEnabled;

// Search Supports
@property (nonatomic, assign) BOOL isSearchItemEnabled;


- (id)initWithRequest:(NSURLRequest *)request;
- (id)initWithURL:(NSURL *)URL;

- (NSURL *)URL;

- (void)openURL:(NSURL*)URL;
- (void)openRequest:(NSURLRequest*)request;
- (void)openHTMLString:(NSString*)htmlString baseURL:(NSURL*)baseUrl;


+ (Class)webViewClass; // 子类重写

- (void)doRefresh;

@end













