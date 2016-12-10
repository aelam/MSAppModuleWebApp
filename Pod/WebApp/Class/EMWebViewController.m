//
//  ymActionWebViewController.m
//  ymActionWebView
//
//  Created by flora on 14-7-3.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMWebViewController.h"
#import "MSAppModuleWebApp.h"
#import "MSAppSettingsWebApp.h"

#import <JLRoutes/JLRoutes.h>
#import <EMSpeed/MSCore.h>
#import <EMSpeed/MSUIKitCore.h>
#import <EMSpeed/UIKitCollections.h>
#import <MSThemeKit/MSThemeKit.h>
#import <EMSocialKit/EMSocialKit.h>

#import <RDVTabBarController/RDVTabBarController.h>
#import <MSAppModuleShare/MSAppModuleShare.h>

#import "NSURL+AuthedURL.h"

// Bridge
#if __has_include(<WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>)
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>
#import <WebViewJavascriptBridge/WebViewJavascriptBridge.h>
#else
@import WebViewJavascriptBridge;
#endif


#import "WebBridgeCore.h"
#import "WebView.h"

// MenuItems
#import "MSSearchMenuItem.h"
#import "MSShareMenuItem.h"
#import "MSCustomMenuItem.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "JSMenuItemButton.h"

// Custom Views
#import "EMWebErrorView.h"
#import "EMWebBackView.h"

// ThemeColors
#import "UIColor+WebApp.h"

// Click
#import "EMClickAdapter.h"

static id <MSAppSettingsWebApp> kModuleSettings = nil;

static NSString *const kNavigaionBarHiddenMetaJS = @"document.getElementsByName('app-navigation-bar-hidden')[0].getAttribute('content')";
static const BOOL kNavigationBarHidden = YES;

@interface EMWebViewController () <UIViewControllerRouter, WKUIDelegate, WKNavigationDelegate>
{
    NSInteger navigationBarStatus;// 储存navigationBar显示状态
    UILongPressGestureRecognizer *_longPress;
    
    NSString *_currentURLString;
    BOOL _isPushBack;
    
}

@property (nonatomic, strong) UIView *statusBarBackView;
@property (nonatomic, strong) EMWebBackView *backView;
@property (nonatomic, strong) NSURLRequest *loadRequest;
@property (nonatomic, strong, readwrite) UIView<XWebView> *webView;
@property (nonatomic, strong, readwrite) UIColor *navigationBarColor;
@property (nonatomic, strong) NSURL *loadingURL;
@property (nonatomic, strong) id<WebViewJavascriptBridgeProtocol>bridge;
@property (nonatomic, strong) JSBridge *jsBridge;

@property (nonatomic, strong) EMWebErrorView *errorView;
@property (nonatomic, strong) Class EMClickClass;

@end

@implementation EMWebViewController


#pragma mark - ModuleSettings
+ (void)setModuleSettings:(id<MSAppSettingsWebApp>)moduleSettings {
    if (kModuleSettings != moduleSettings) {
        kModuleSettings = moduleSettings;
    }
}

+ (id<MSAppSettingsWebApp>)moduleSettings {
    return kModuleSettings;
}

+ (Class)webViewClass {
    return [UIWebView class];
}

- (void)dealloc {
    [self.jsBridge reset];
    
    self.bridge = nil;
    self.jsBridge = nil;
    
    [self.webView setUIDelegate:nil];
    self.webView = nil;
    self.backView = nil;
    self.loadingURL = nil;
    self.loadRequest = nil;
}

- (instancetype)initWithRouterParams:(NSDictionary *)params {
    NSString *urlString = params[@"url"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    self = [self initWithURL:url];
    
    if (self) {
        self.eventAttributes = [self eventAttributesFromJLRoutesParams:params];
        
        NSString *navigationBarHidden = params[@"navigationBarHidden"];
        NSString *navigaionBarHidden = params[@"navigaionBarHidden"]; // 之前的拼写错误
        if (navigationBarHidden.length > 0) {
            navigationBarStatus = [navigationBarHidden integerValue];
        } else if (navigaionBarHidden.length > 0) {
            navigationBarStatus = [navigaionBarHidden integerValue];
        } else {
            navigationBarStatus = 0;
        }
    }
    
    return self;
}

- (instancetype)initWithURL:(NSURL *)URL {
    NSURL *url = [NSURL authedURLWithURL:URL];
    return [self initWithRequest:[NSURLRequest requestWithURL:url]];
}

- (instancetype)init {
    self = [self initWithRequest:nil];
    if (self) {
    }
    return self;
}

#pragma mark -
#pragma mark life cycle

- (instancetype)initWithRequest:(NSURLRequest *)request {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.synchronizeDocumentTitle = YES;
        
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeAll;
        }
        
        [self setShowsCloseButton:YES];
        
        if (request) {
            [self openRequest:request];
        }
    }
    
    
    return self;
}

- (void)setShowsCloseButton:(BOOL)showsCloseButton {
    _showsCloseButton = showsCloseButton;
    if (_showsCloseButton) {
        [self loadBackView];
    } else {
        [self unloadBackView];
    }
}

/**
 * 子类可通过复现当前类，修改返回方案
 */
- (void)loadBackView {
    //生成导航条返回按键
    self.backView = [[EMWebBackView alloc] initWithParamSupportClose:YES];
    self.backView.titleColor = [UIColor web_navbarItemTextColor];
    
    [self.backView addTarget:self backAction:@selector(doBack) closeAction:@selector(doClose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backView];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)unloadBackView {
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpWebView];
    
    _isPushBack = NO;
    
    if (nil != self.loadRequest) {
        [self.webView x_loadRequest:self.loadRequest];
    }
    self.backView.supportClose = [self supportClose];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self changeTabbarStatus];
    [self changeNavigationBarStatusAnimated:animated];
    [self changeNavigaiotnBarColor];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_isPushBack) {
        [self trackBackFromViewDidAppear];
        _isPushBack = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    navigationBarStatus = self.navigationController.navigationBarHidden;
    [self showNetworkActivityIndicator:NO];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self endTrackingLastPage];
    
    _isPushBack = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - WebView
- (void)setUpWebView {
    // [[JSBridge sharedBridge] attachToBridge:self.bridge];调用的时机不一样
    // WKWebView通过userContentController 注入脚本
    // UIWebView在获取JSContext的时候注入脚本
    
    if (NSClassFromString(@"WKWebView") &&
        [kModuleSettings respondsToSelector:@selector(WKWebViewEnabled)] &&
        [kModuleSettings WKWebViewEnabled]) {
        [WKWebViewJavascriptBridge enableLogging];
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;
        
        // 显示WKWebView
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
        wkWebView.UIDelegate = self; // 设置WKUIDelegate代理
        wkWebView.navigationDelegate = self; // 设置WKNavigationDelegate代理
        [self.view addSubview:wkWebView];
        
        _webView = (UIView<XWebView> *)wkWebView;
        
        [self bridgeWithWebView];
        
        [self.jsBridge attachToBridge:self.bridge];
        
    } else {
        [WebViewJavascriptBridge enableLogging];
        
        UIWebView *webView = [[[[self class] webViewClass] alloc] initWithFrame:self.view.bounds];
        UIColor *bgColor = [UIColor web_bgColor];
        
        webView.backgroundColor = bgColor;
        webView.scrollView.backgroundColor = bgColor;
        
        webView.opaque = NO;
        webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        webView.scrollView.clipsToBounds = YES;
        webView.delegate = self;
        webView.scalesPageToFit = YES;
        [self.view addSubview:webView];
        _webView = (UIView<XWebView> *)webView;
        
        [self bridgeWithWebView];
    }
}

- (void)bridgeWithWebView {
    
    if (!self.bridge) {
        
        if ([_webView isKindOfClass:[WKWebView class]]) {
            self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:(WKWebView *)_webView];
        } else {
            self.bridge = [WebViewJavascriptBridge bridgeForWebView:(UIWebView *)_webView];
        }
        
        [self.bridge setWebViewDelegate:self];
        
        self.jsBridge = [JSBridge new];
        
        self.jsBridge.javaScriptBridge = self.bridge;
        self.jsBridge.viewController = self;
        self.jsBridge.webView = _webView;
    }
}

- (void)showErrorView {
    if (!self.errorView) {
        self.errorView = [[EMWebErrorView alloc] initWithFrame:self.view.bounds];
        [self.webView addSubview:self.errorView];
        
        __weak __typeof(self) weakSelf = self;
        __weak __typeof(UIView<XWebView> *) webView = self.webView;
        self.errorView.tapBlock = ^() {
            [weakSelf hideErrorView];
            [webView x_loadRequest:weakSelf.loadRequest];
        };
    }
    self.errorView.frame = self.webView.bounds;
    self.errorView.hidden = NO;
}

- (void)hideErrorView {
    self.errorView.hidden = YES;
}

#pragma mark - Override
/**是否需要退出当前页面
 */
- (BOOL)supportClose {
    return ([self.navigationController.viewControllers count] > 1 || self.presentingViewController) ? YES : NO;
}

- (void)changeTabbarStatus {
    [self.rdv_tabBarController setTabBarHidden:YES];
}

- (void)changeNavigationBarStatusAnimated:(BOOL)animated {
    if (navigationBarStatus != -1) {
        [self.navigationController setNavigationBarHidden:navigationBarStatus animated:NO];
    }
}

- (void)changeNavigaiotnBarColor {
    
}

- (void)reloadTitle {
    //提取页面的标题作为当前controller的标题
    __weak typeof(self) weakSelf = self;
    [self getRemoteTitleWithHandler:^(NSString *title) {
        if (title && title.length) {
            weakSelf.title = title;
        }
    }];
}

- (void)getRemoteTitleWithHandler:(nullable void (^)(NSString *title))handler {
    [self.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable rs, NSError *_Nullable error) {
        handler(rs);
    }];
}

// 显示高度为20的view盖住webview
- (void)showTopStatusBarViewWithNavigationBarHidden:(BOOL)navigationBarHidden {
    if (navigationBarHidden) {
        CGRect topBarRect = self.view.bounds;
        topBarRect.size.height = 20;
        if (self.statusBarBackView == nil) {
            self.statusBarBackView = [[UIView alloc] initWithFrame:topBarRect];
            self.statusBarBackView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        } else {
            self.statusBarBackView.frame = topBarRect;
        }
        
        self.statusBarBackView.backgroundColor = [UIColor web_statusBarColor];
        [self.view addSubview:self.statusBarBackView];
    } else {
        [self.statusBarBackView removeFromSuperview];
    }
}

- (void)updateWebViewPropertiesWithNavigationBarHidden:(BOOL)navigationBarHidden {
    if (navigationBarHidden) {
        self.webView.opaque = YES;
        self.webView.scrollView.bounces = NO;
    } else {
        self.webView.opaque = NO;
        self.webView.scrollView.bounces = YES;
    }
}

#pragma mark -
#pragma mark UIWebView delegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self showNetworkActivityIndicator:NO];
    NSLog(@"%zd %@", error.code,[error localizedDescription]);
    
    if([error code] == NSURLErrorCancelled /* -999 */) {
    } else if (error.code == NSURLErrorServerCertificateUntrusted /* -1202 */) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请确认网页的证书"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
    } else {
        [self showErrorView];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    NSURL *url = request.URL;
    NSString *lowercaseScheme = [[url scheme] lowercaseString];
                                 
    if ([lowercaseScheme isEqualToString:@"tel"] ||
        [lowercaseScheme isEqualToString:@"telprompt"] ||
        [lowercaseScheme isEqualToString:@"sms"]) {
        return YES;
    } else if ([[kModuleSettings supportsURLSchemes] containsObject:url.scheme]) {
        [JLRoutes routeURL:url];
        return NO;
    } else if ([lowercaseScheme hasPrefix:@"http"] ||
        [lowercaseScheme hasPrefix:@"file"]
        ) {
        self.loadRequest = request;
    }
    
    return YES;
}

// 使用hash跳转不会进入- (void)webViewDidFinishLoad:(UIWebView *)webView
// 所以在里面-shouldStartLoadWithRequest 中调用[self showNetworkActivityIndicator:YES];
// Indicator 无法再-webViewDidFinishLoad中停止
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    NSURL *url = [self.loadRequest URL];
    
    if ([[[url scheme] lowercaseString] hasPrefix:@"http"] ||
        [[[url scheme] lowercaseString] hasPrefix:@"file"]
        ) {
        [self showNetworkActivityIndicator:YES];
        [self beginTrackingEventsWithURL:url];
    }
    
}

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)ctx {
    self.jsBridge.javascriptContext = ctx;
    [self.jsBridge attachToBridge:self.bridge];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self showNetworkActivityIndicator:NO];
    
    if (self.synchronizeDocumentTitle) {
        [self reloadTitle];
    }
    
    self.backView.showGoBack = self.webView.canGoBack;
    [self updateNavigationBarByMeta];
    
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(coverWebviewAction:)];
        _longPress.minimumPressDuration = 0.4;
        _longPress.numberOfTouchesRequired = 1;
        [webView.scrollView addGestureRecognizer:_longPress];
    }
}

#pragma mark - WKWebView Delegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self reloadTitle];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    [self presentViewController:alertController animated:YES completion:^{}];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    completionHandler(YES);
}

- (void)coverWebviewAction:(UIGestureRecognizer *)gesture {
    
}

#pragma mark -
- (void)updateNavigationBarByMeta {
    NSString *js = kNavigaionBarHiddenMetaJS;
    
    __block BOOL hide = NO;
    __weak typeof(self) weakSelf = self;
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable hiddenObject, NSError *_Nullable error) {
        hide = [[hiddenObject lowercaseString] isEqualToString:@"yes"];
        [weakSelf _hideNavigationBar:hide];
    }];
}

- (void)_hideNavigationBar:(BOOL)hide {
    BOOL changed = NO;
    if (hide
        ) {
        if (!self.navigationController.navigationBarHidden) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController setNavigationBarHidden:YES animated:YES];
            });
            changed = YES;
        }
        navigationBarStatus = kNavigationBarHidden;
        [self showTopStatusBarViewWithNavigationBarHidden:YES];
        [self updateWebViewPropertiesWithNavigationBarHidden:YES];
    } else {
        if (self.navigationController.navigationBarHidden) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            changed = YES;
        }
        navigationBarStatus = -1;
        [self showTopStatusBarViewWithNavigationBarHidden:NO];
        [self updateWebViewPropertiesWithNavigationBarHidden:NO];
    }
    
    if (changed) {
    }
}

#pragma mark -
#pragma mark Public
- (NSURL *)URL {
    return self.loadingURL ? self.loadingURL : self.webView.URL;
}

- (void)openURL:(NSURL *)URL {
    self.loadingURL = URL;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [self openRequest:request];
}

- (void)openRequest:(NSURLRequest *)request {
    self.loadRequest = request;
    
    if ([self isViewLoaded]) {
        if (nil != request) {
            [self.webView x_loadRequest:request];
        } else {
            [self.webView stopLoading];
        }
    }
}

- (void)openHTMLString:(NSString *)htmlString baseURL:(NSURL *)baseUrl {
    [_webView x_loadHTMLString:htmlString baseURL:baseUrl];
}

#pragma mark - Menu Items
- (void)setIsShareItemEnabled:(BOOL)isShareItemEnabled {
    if (_isShareItemEnabled != isShareItemEnabled) {
        _isShareItemEnabled = isShareItemEnabled;
        [self updateRightItems];
    }
}

- (void)setIsSearchItemEnabled:(BOOL)isSearchItemEnabled {
    if (_isSearchItemEnabled != isSearchItemEnabled) {
        _isSearchItemEnabled = isSearchItemEnabled;
        [self updateRightItems];
    }
    
}

- (void)updateRightItems {
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:2];
    if (_isSearchItemEnabled) {
        [items addObject:[self searchItem]];
    }
    
    if (_isShareItemEnabled) {
        [items addObject:[self shareItem]];
    }
    
    self.navigationItem.rightBarButtonItems = items;
}

- (UIBarButtonItem *)shareItem {
    MSCustomMenuItem *customMenuItem = [MSCustomMenuItem new];
    customMenuItem.icon = @"web_share";
    
    JSMenuItemButton *button = [[JSMenuItemButton alloc] init];
    button.tintColor = [UIColor web_navbarItemTextColor];
    button.menuItem = customMenuItem;
    
    [button addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

    return buttonItem;
}

- (UIBarButtonItem *)searchItem {
    MSCustomMenuItem *customMenuItem = [MSCustomMenuItem new];
    customMenuItem.icon = @"web_search";

    JSMenuItemButton *button = [[JSMenuItemButton alloc] init];
    button.tintColor = [UIColor web_navbarItemTextColor];
    button.menuItem = customMenuItem;
    
    [button addTarget:self action:@selector(doSearch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return buttonItem;
}



- (void)setMenuItems:(NSArray <MSMenuItemData *> *)items {
    if (_menuItems != items) {
        _menuItems = items;
        [self updateRightItems2];
    }
}

- (void)updateRightItems2 {
    NSMutableArray *items = [NSMutableArray array];
    
    NSEnumerator <MSMenuItemData *> *e = [_menuItems reverseObjectEnumerator];
    MSMenuItemData *item = nil;
    while (item = [e nextObject]) {
        MSCustomMenuItem *customMenuItem = (MSCustomMenuItem *)item;
        JSMenuItemButton *button = [[JSMenuItemButton alloc] init];
        button.tintColor = [UIColor web_navbarItemTextColor];
        button.menuItem = customMenuItem;
        
        [button addTarget:self action:@selector(customMeunItemButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [items addObject:buttonItem];
    }
    
    self.navigationItem.rightBarButtonItems = items;
}

- (void)customMeunItemButtonTapped:(JSMenuItemButton *)button {
    [self.webView x_evaluateJavaScript:[NSString stringWithFormat:@"%@()", button.menuItem.action]];
}

#pragma mark -
#pragma mark actions

/**按键按键处理步骤
 * 1、如果网页可返回，返回网页
 * 2、如果网页不可返回且支持回退功能，回退上一页
 * 3、如果网页不可返回且不支持回退功能，重置当前backView状态
 */
- (void)doBack {
    if ([self.webView canGoBack]) {
        [self.webView x_goBack];
        [self.backView goBack];
    } else {
        if (self.backView.supportClose) {
            [self doClose];
        } else {
            self.backView.showGoBack = self.webView.canGoBack;
        }
    }
}

/**回退到上一页，pop或dismiss
 */
- (void)doClose {
    if (self.navigationController && [self.navigationController.viewControllers count] > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - KeyCommands
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (NSArray *)keyCommands {
    NSMutableArray *keyCommands = [NSMutableArray array];;
    NSArray *superKeyCommands = [super keyCommands];
    if (superKeyCommands == nil) {
    } else {
        [keyCommands addObjectsFromArray:superKeyCommands];
    }
    [keyCommands addObject:[UIKeyCommand keyCommandWithInput:@"r" modifierFlags:UIKeyModifierCommand action:@selector(commandRPressed:)]];
    return keyCommands;
}

- (void)commandRPressed:(id)sender {
    [_webView x_reload];
}

- (void)showNetworkActivityIndicator:(BOOL)visible {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:visible];
}

- (void)doRefresh {
    if ([_webView canGoBack]) {
        [_webView x_reload];
    } else {
        if (nil != self.loadRequest) {
            [self.webView x_loadRequest:self.loadRequest];
        }
    }
}

- (void)doSearch {
    [self event:@"web:search" attributes:self.eventAttributes];
    if ([super respondsToSelector:_cmd]) {
        [super doSearch];
    }
}

- (void)doShare {
    if (self.shareEntity) {
        [self share:self.shareEntity];
    }
}

#pragma mark - Share
- (void)share:(EMShareEntity *)shareEntity {
    [self event:@"web:share" attributes:self.eventAttributes];
    
    NSString *callback = shareEntity.callback;
    
    [[EMSocialSDK sharedSDK] shareEntity:shareEntity rootViewController:self completionHandler:^(NSString *activityType, BOOL completed, NSDictionary *returnedInfo, NSError *activityError) {
        EMSocialType socialType = 0;
        NSInteger statusCode = 0;
        NSNumber *errorCode;
        
        NSString *message = nil;
        if ([activityType isEqualToString:UIActivityTypePostToSinaWeibo]) {
            message = returnedInfo[EMActivityWeiboStatusMessageKey];
            socialType = EMSocialTypeSinaWeibo;
        } else if ([activityType isEqualToString:UIActivityTypePostToWeChatSession]) {
            message = returnedInfo[EMActivityWeChatStatusMessageKey];
            socialType = EMSocialTypeWeChat;
        } else if ([activityType isEqualToString:UIActivityTypePostToWeChatTimeline]) {
            message = returnedInfo[EMActivityWeChatStatusMessageKey];
            socialType = EMSocialTypeMoments;
        } else if ([activityType isEqualToString:UIActivityTypePostToQQ]) {
            message = returnedInfo[EMActivityQQStatusMessageKey];
            socialType = EMSocialTypeQQ;
        }
        
        errorCode = returnedInfo[EMActivityGeneralStatusCodeKey];
        message = returnedInfo[EMActivityGeneralMessageKey];
        if (errorCode) {
            NSInteger code = [errorCode integerValue];
            if (code == EMActivityGeneralStatusCodeSuccess) {
                statusCode = 0;
            } else if (code == EMActivityGeneralStatusCodeUserCancel) {
                statusCode = -1;
            } else {
                statusCode = -2;
            }
        }
        
        
        if (callback.length > 0) {
            NSString *script = [NSString stringWithFormat:@"%@(%zd,%zd)", callback, socialType, statusCode];
            // FIXME: 在callback指明却不实现的情况直接使用webview会卡死
            if (self.jsBridge.javascriptContext) {
                [self.jsBridge.javascriptContext evaluateScript:script];
            } else {
                [_webView x_evaluateJavaScript:script];
            }
        } else {
            if (message.length > 0) {
                [BDKNotifyHUD showNotifHUDWithText:message];
            }
        }
    }];
}

#pragma mark - EMClick
// 页面开始的时候统计从`-webViewDidStartLoad`开始
// 当pop回webviewcontroller的时候`-webViewDidStartLoad`不会调用
// 这个时候在`-viewDidAppear`里面统计这个page
- (void)trackBackFromViewDidAppear {
    if (_currentURLString) {
        [self beginLogPageView:@"web"];
    }
}

- (void)beginTrackingEventsWithURL:(NSURL *)url {
    [self endTrackingLastPage];
    
    NSString *scheme = url.scheme;
    NSString *host = url.host;
    NSString *relativePath = url.relativePath;
    
    NSString *urlString = [NSString stringWithFormat:@"%@://%@%@",scheme,host,relativePath];

    _currentURLString = urlString;
    
    [self beginLogPageView:@"web"];
}

- (void)endTrackingLastPage {
    
    if (_currentURLString.length > 0) {
        __block NSMutableDictionary *atrributes = [NSMutableDictionary dictionary];
        if (self.eventAttributes) {
            [atrributes addEntriesFromDictionary:self.eventAttributes];
        }
        atrributes[@"url"] = _currentURLString;
        
        __weak typeof(self)weakSelf = self;
        
        [self getRemoteTitleWithHandler:^(NSString *title) {
            if (title && title.length) {
                atrributes[@"title"] = title;
            }
            [weakSelf endLogPageView:@"web" attributes:atrributes];
        }];
    }
}

- (NSDictionary *)eventAttributesFromJLRoutesParams:(NSDictionary *)params {
    NSMutableDictionary *eventsAtrributes = [params mutableCopy];
    
    [eventsAtrributes removeObjectForKey:@"JLRoutePattern"];
    [eventsAtrributes removeObjectForKey:@"JLRouteURL"];
    [eventsAtrributes removeObjectForKey:@"JLRouteScheme"];
    [eventsAtrributes removeObjectForKey:@"JLRouteWildcardComponents"];
    [eventsAtrributes removeObjectForKey:@"JLRoutesGlobalRoutesScheme"];
    
    return eventsAtrributes;
}

- (Class)EMClickClass {
    if (_EMClickClass == nil) {
        if ([kModuleSettings respondsToSelector:@selector(EMClickClass)]) {
            _EMClickClass = kModuleSettings.EMClickClass;
        }
    }
    return _EMClickClass;
}

- (void)event:(NSString *)event {
    if ([[self EMClickClass] respondsToSelector:@selector(event:)]) {
        [[self EMClickClass] event:event];
    }
}

- (void)event:(NSString *)event attributes:(NSDictionary *)attributes {
    if ([[self EMClickClass] respondsToSelector:@selector(event:attributes:)]) {
        [[self EMClickClass] event:event attributes:attributes];
    }
}

- (id)beginLogPageView:(NSString *)pageId {
    if ([[self EMClickClass] respondsToSelector:@selector(beginLogPageView:)]) {
        [[self EMClickClass] beginLogPageView:pageId];
    }
}

- (void)endLogPageView:(NSString *)pageId attributes:(NSDictionary *)attributes {
    if ([[self EMClickClass] respondsToSelector:@selector(endLogPageView:attributes:)]) {
        [[self EMClickClass] endLogPageView:pageId attributes:attributes];
    }

}

@end
