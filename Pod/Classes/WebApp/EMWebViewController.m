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
#import <EMSpeed/MSUIKitCore.h>
#import <MSThemeKit/MSThemeKit.h>
#import <EMClick/EMClick.h>
#import <RDVTabBarController/RDVTabBarController.h>
#import <EMSocialKit/EMSocialSDK.h>
#import <BDKNotifyHUD.h>
#import <JavaScriptCore/JavaScriptCore.h>

#import "EMSocialSDK+URLBind.h"

#import "EMWebBackView.h"
#import "UIWebView+jsToObject.h"
#import "UIWebView+JSExtend.h"
#import "MSWebAppInfo.h"
#import "MSAppSettingsWebApp.h"
#import <EMSpeed/MSCore.h>
#import "NSURL+AuthedURL.h"
#import "JSBridge.h"
#import "UIWebView+Context.h"
#import "UIWebView+TS_JavaScriptContext.h"
#import "JSBridgeModule.h"

#define kJSBridgeFileName @"EMJSBridge.js"

typedef void (^JSBridgeBlock)(NSDictionary *info);

static NSString *const kNavigaionBarHiddenMetaJS = @"document.getElementsByName('app-navigation-bar-hidden')[0].getAttribute('content')";
static const BOOL kNavigationBarHidden = YES;

@interface EMWebViewController () <UIViewControllerRouter>
{
    NSInteger navigationBarStatus;// 储存navigationBar显示状态
    UILongPressGestureRecognizer *_longPress;
    
    NSString *_currentURLString;
    BOOL     _isPushBack;
}

@property (nonatomic, strong) UIView *statusBarBackView;
@property (nonatomic, strong) EMWebBackView *backView;
@property (nonatomic, strong) NSURLRequest* loadRequest;
@property (nonatomic, strong, readwrite) UIWebView *webView;
@property (nonatomic, strong, readwrite) UIColor *navigationBarColor;
@property (nonatomic, strong) NSURL* loadingURL;
@property (nonatomic, strong) JSContext *context;

@end

@implementation EMWebViewController


+ (Class)webViewClass
{
    return [UIWebView class];
}

- (void)dealloc
{
    self.webView.delegate = nil;
    self.webView  = nil;
    self.backView = nil;
    self.loadingURL  = nil;
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
        } else if(navigaionBarHidden.length > 0){
            navigationBarStatus = [navigaionBarHidden integerValue];
        }else {
            navigationBarStatus = 0;
        }
    }
    
    return self;
}


- (instancetype)initWithURL:(NSURL *)URL {
    NSURL *url = [NSURL authedURLWithURL:URL];
    return [self initWithRequest:[NSURLRequest requestWithURL:url]];
}

- (instancetype)init
{
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
        
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        {
            self.edgesForExtendedLayout = UIRectEdgeAll;
        }
        
        [self setShowsCloseButton:YES];
        
        if (request)
        {
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
 *子类可通过复现当前类，修改返回方案
 */
- (void)loadBackView
{
    //生成导航条返回按键
    self.backView = [[EMWebBackView alloc] initWithParamSupportClose:YES];
    [self.backView addTarget:self backAction:@selector(doBack) closeAction:@selector(doClose) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.backView];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)unloadBackView {
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _webView = [[[[self class] webViewClass] alloc] initWithFrame:self.view.bounds];
    _webView.backgroundColor = [UIColor colorForKey:@"common_bgColor"];
    _webView.scrollView.backgroundColor = [UIColor colorForKey:@"common_bgColor"];
    
    _webView.opaque = NO;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _webView.scrollView.clipsToBounds = YES;
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:self.webView];

    _isPushBack = NO;
    
    if (nil != self.loadRequest) {
        [self.webView loadRequest:self.loadRequest];
    }
    self.backView.supportClose = [self supportClose];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
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

- (void)viewWillDisappear:(BOOL)animated
{
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

#pragma mark - Override
/**是否需要退出当前页面
 */
- (BOOL)supportClose
{
    return ([self.navigationController.viewControllers count] > 1 || self.presentingViewController) ? YES : NO;
}

- (void)changeTabbarStatus
{
    [self.rdv_tabBarController setTabBarHidden:YES];
}

- (void)changeNavigationBarStatusAnimated:(BOOL)animated {
    if (navigationBarStatus != -1) {
        [self.navigationController setNavigationBarHidden:navigationBarStatus animated:NO];
    }
}

- (void)changeNavigaiotnBarColor {
    
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
        
        self.statusBarBackView.backgroundColor = [UIColor colorForKey:@"common_webStatusBarColor"];
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

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self showNetworkActivityIndicator:NO];
    NSLog(@"%@ %ld", error.domain, (long)error.code);
    
    if (-1202 == error.code)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: @"请确认网页的证书"
                                                       delegate: nil
                                              cancelButtonTitle: nil
                                              otherButtonTitles: @"确定", nil];
        [alert show];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    MSAppModuleWebApp *webApp = [appModuleManager appModuleWithModuleName:NSStringFromClass([MSAppModuleWebApp class])];
    id<MSAppSettingsWebApp> settings = (id<MSAppSettingsWebApp>)[webApp moduleSettings];
    
    NSURL *url = request.URL;
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        if ([url.scheme isEqualToString:@"tel"]||
            [url.scheme isEqualToString:@"telprompt"])
        {
            NSString *phoneNum = url.resourceSpecifier;
            MSMakePhoneCall(phoneNum);
            
            return NO;
        }
        else if ([url.scheme isEqualToString:@"sms"])
        {
            // TODO
            return NO;
        }
    }
    else if([[settings supportsURLSchemes] containsObject:url.scheme]){
        [JLRoutes routeURL:url];
        return NO;
    }
    
    [self showNetworkActivityIndicator:YES];
    
    if([[[url scheme] lowercaseString] hasPrefix:@"http"]) {
        [self beginTrackingEventsWithURL:url];
    }

    return YES;
}

- (void)reloadTitle
{        //提取页面的标题作为当前controller的标题
    NSString *title = [self remoteTitle];
    if (title && title.length)
    {
        self.title = title;
    }
}

- (NSString *)remoteTitle {
    return [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
}

- (void)loadJSBridge:(NSString *)source {

    JSContext *context = [_webView ts_javaScriptContext];
    
    [JSBridge sharedBridge].webView = _webView;
    [JSBridge sharedBridge].viewController = self;

    [[JSBridge sharedBridge] loadModules];

    NSString *jsPath = [[NSBundle bundleForClass:self] pathForResource:kJSBridgeFileName ofType:nil];
    NSString *jsSourceCode = [[NSString alloc] initWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:NULL];
    [context evaluateScript:jsSourceCode];
    
    JSValue *goods = [context objectForKeyedSubscript:@"goods"];

    NSObject<JSBridgeModule> *module = [[JSBridge sharedBridge]modules];
    if ([module respondsToSelector:@selector(subscriptKey)] &&
        [module respondsToSelector:@selector(subscriptObject)]) {
        [goods setObject:[module subscriptObject] forKeyedSubscript:[module subscriptKey]];
    }

}

- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext *)ctx
{
    [self loadJSBridge:@"didCreateJavaScriptContext"];

}


- (void)webViewDidFinishLoad:(UIWebView*)webView
{
    //执行脚本
//    [_webView loadActionJavaScript];
//    [_webView loadExtendActions];
    [self loadJSBridge:@"webViewDidFinishLoad"];

    [self showNetworkActivityIndicator:NO];
    
    if (self.synchronizeDocumentTitle)
    {
        [self reloadTitle];
    }
    [self.backView updateWithCurrentWebView:webView];
    [self updateNavigationBarByMeta];
    
    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(coverWebviewAction:)];
        _longPress.minimumPressDuration = 0.4;
        _longPress.numberOfTouchesRequired = 1;
        [webView.scrollView addGestureRecognizer:_longPress];
    }
}


- (void)coverWebviewAction:(UIGestureRecognizer *)gesture {
    
}

#pragma mark -
- (void)updateNavigationBarByMeta {
    NSString *js = kNavigaionBarHiddenMetaJS;
    NSString *rs = [_webView stringByEvaluatingJavaScriptFromString:js];
    BOOL changed = NO;
    if ([[rs lowercaseString] isEqualToString:@"yes"]) {
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
- (NSURL *)URL
{
    return self.loadingURL ? self.loadingURL : self.webView.request.mainDocumentURL;
}

- (void)openURL:(NSURL*)URL
{
    self.loadingURL = URL;
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    [self openRequest:request];
}

- (void)openRequest:(NSURLRequest *)request
{
    self.loadRequest = request;
    
    if ([self isViewLoaded])
    {
        if (nil != request)
        {
            [self.webView loadRequest:request];
            
        } else {
            [self.webView stopLoading];
        }
    }
}

- (void)openHTMLString:(NSString*)htmlString baseURL:(NSURL*)baseUrl
{
    [_webView loadHTMLString:htmlString baseURL:baseUrl];
}

#pragma mark - Share
- (void)setIsShareItemEnabled:(BOOL)isShareItemEnabled {
    if (_isShareItemEnabled != isShareItemEnabled) {
        _isShareItemEnabled = isShareItemEnabled;
        [self updateRightItems];
    }
}

- (void)setIsSearchItemEnabled:(BOOL)isSearchItemEnabled {
    if(_isSearchItemEnabled != isSearchItemEnabled) {
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


#pragma mark -
#pragma mark actions

/**按键按键处理步骤
 *1、如果网页可返回，返回网页
 *2、如果网页不可返回且支持回退功能，回退上一页
 *3、如果网页不可返回且不支持回退功能，重置当前backView状态
 */
- (void)doBack
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
        [self.backView goBack];
    }
    else
    {
        if (self.backView.supportClose)
        {
            [self doClose];
        }
        else
        {
            [self.backView updateWithCurrentWebView:self.webView];
        }
    }
}

/**回退到上一页，pop或dismiss
 */
- (void)doClose
{
    if (self.navigationController && [self.navigationController.viewControllers count] > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
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
    [_webView reload];
}

- (void)showNetworkActivityIndicator:(BOOL)visible {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:visible];
}

- (void)doRefresh
{
    if ([_webView canGoBack])
    {
        [_webView reload];
    }
    else
    {
        if (nil != self.loadRequest) {
            [self.webView loadRequest:self.loadRequest];
        }
    }
}

- (void)doSearch
{
    [EMClick event:@"web:search" attributes:self.eventAttributes];
    if ([super respondsToSelector:_cmd]) {
        [super doSearch];
    }
}

#pragma mark - Share
- (void)share:(EMShareEntity *)shareEntity {
    [EMClick event:@"web:share" attributes:self.eventAttributes];
    NSString *callback = shareEntity.callback;
    
    [[EMSocialSDK sharedSDK] shareEntity:shareEntity rootViewController:self completionHandler:^(NSString *activityType, BOOL completed, NSDictionary *returnedInfo, NSError *activityError) {
        EMSocialType socialType = 0;
        NSInteger statusCode = 0;
        
        NSString *message = nil;
        if ([activityType isEqualToString:UIActivityTypePostToSinaWeibo]) {
            message = returnedInfo[EMActivityWeiboStatusMessageKey];
            socialType = EMSocialTypeSinaWeibo;
            NSNumber *errorCode = returnedInfo[EMActivityWeiboStatusCodeKey];
            if (errorCode) {
                if([errorCode integerValue] == EMActivityWeiboStatusCodeSuccess) {
                    statusCode = 0;
                } else if([errorCode integerValue] == EMActivityWeiboStatusCodeUserCancel) {
                    statusCode = -1;
                }
            }
        } else if([activityType isEqualToString:UIActivityTypePostToWeChatSession]) {
            message = returnedInfo[EMActivityWeChatStatusMessageKey];
            socialType = EMSocialTypeWeChat;
            NSNumber *errorCode = returnedInfo[EMActivityWeChatStatusCodeKey];
            if (errorCode) {
                if([errorCode integerValue] == EMActivityWeChatStatusCodeSuccess) {
                    statusCode = 0;
                } else if([errorCode integerValue] == EMActivityWeChatStatusCodeUserCancel) {
                    statusCode = -1;
                }
            }
            
        } else if([activityType isEqualToString:UIActivityTypePostToWeChatTimeline]) {
            message = returnedInfo[EMActivityWeChatStatusMessageKey];
            socialType = EMSocialTypeMoments;
            NSNumber *errorCode = returnedInfo[EMActivityWeChatStatusCodeKey];
            if (errorCode) {
                if([errorCode integerValue] == EMActivityWeChatStatusCodeSuccess) {
                    statusCode = 0;
                } else if([errorCode integerValue] == EMActivityWeChatStatusCodeUserCancel) {
                    statusCode = -1;
                }
            }
        } else if ([activityType isEqualToString:UIActivityTypePostToQQ]) {
            message = returnedInfo[EMActivityQQStatusMessageKey];
            socialType = EMSocialTypeQQ;
            NSNumber *errorCode = returnedInfo[EMActivityQQStatusCodeKey];
            if (errorCode) {
                if([errorCode integerValue] == EMActivityQQStatusCodeSuccess) {
                    statusCode = 0;
                } else if([errorCode integerValue] == EMActivityQQStatusCodeUserCancel) {
                    statusCode = -1;
                }
            }
        }
        
        if (callback.length > 0) {
            NSString *script = [NSString stringWithFormat:@"%@(%zd,%zd)", callback, socialType, statusCode];
            [self.webView stringByEvaluatingJavaScriptFromString:script];
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
    if(_currentURLString) {
        [EMClick beginLogPageView:@"web"];
    }
}

- (void)beginTrackingEventsWithURL:(NSURL *)url {
    [self endTrackingLastPage];
    
    _currentURLString = [url absoluteString];
    
    [EMClick beginLogPageView:@"web"];
}

- (void)endTrackingLastPage {
    
    if (_currentURLString.length > 0) {
        NSMutableDictionary *atrributes = [NSMutableDictionary dictionary];
        if (self.eventAttributes) {
            [atrributes addEntriesFromDictionary:self.eventAttributes];
        }
        atrributes[@"url"] = _currentURLString;
        NSString *title = [self remoteTitle];
        if (title.length > 0) {
            atrributes[@"title"] = title;
        }
        
        [EMClick endLogPageView:@"web" attributes:atrributes];
    }
}

- (NSDictionary *)eventAttributesFromJLRoutesParams:(NSDictionary *)params {
    NSMutableDictionary *eventsAtrributes = [params mutableCopy];
    
    [eventsAtrributes removeObjectForKey:kJLRoutePatternKey];
    [eventsAtrributes removeObjectForKey:kJLRouteURLKey];
    [eventsAtrributes removeObjectForKey:kJLRouteNamespaceKey];
    [eventsAtrributes removeObjectForKey:kJLRouteWildcardComponentsKey];
    [eventsAtrributes removeObjectForKey:kJLRoutesGlobalNamespaceKey];
    
    return eventsAtrributes;
}

@end

