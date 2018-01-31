//
//  JLRoutes+WebApp.m
//  Pods
//
//  Created by ryan on 3/17/16.
//
//

#import "JLRoutes+WebApp.h"
#import <EMSpeed/UIKitCollections.h>
#import <MSRoutes/MSRoutes.h>
#import "EMWebViewController.h"
#import "WebView.h"
#import <MSThemeKit/MSThemeKit.h>

@implementation JLRoutes (WebApp)

- (void)registerWebRoutesWithAppSettings:(id<MSAppSettings>)settings {
    [self registerWebWithAppSettings:(id<MSAppSettings>)settings];
    [self registerGoBack];
}

- (void)registerWebWithAppSettings:(id<MSAppSettings>)settings {
    __weak __typeof(self)weakSelf = self;
    [self addRoute:@"web" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSURL *URL = [NSURL URLWithString:parameters[@"url"]];
        NSString *scheme = [URL scheme];
        NSString *lowerScheme = [scheme lowercaseString];
        if ([settings.supportsURLSchemes containsObject:scheme]) {

            return [JLRoutes routeURL:URL];

        } else if ([lowerScheme isEqualToString:@"http"] ||
                   [lowerScheme isEqualToString:@"https"] ||
                   [lowerScheme hasPrefix:@"file"]) {

            [weakSelf handleWebHttpRoute:parameters];

            return true;
        } else {
            return false;
        }
    }];
}

/**
 *  注册网页返回`goBack`
 */
- (void)registerGoBack {
    // 网页返回
    // 保证WebViewController 有webview属性
    BOOL (^completion)(NSDictionary *) = ^BOOL(NSDictionary *parameters) {
        EMWebViewController *webViewController = (EMWebViewController *)[MSActiveControllerFinder finder].activeTopController();
        if ([webViewController respondsToSelector:@selector(webView)]) {
            [[webViewController webView] x_goBack];
        }
        return YES;
    };

    [self addRoutes:@[@"goBack", @"goback"] handler:completion];
}


- (void)unregisterWebRoutesWithAppSettings:(id<MSAppSettings>)settings {
    [self removeRoute:@"web"];
    [self removeRoute:@"goBack"];
    [self removeRoute:@"goback"];
}

- (void)handleWebHttpRoute:(NSDictionary<NSString *, id> *)parameters
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    NSString *urlString = parameters[@"url"];

    urlString = [self handleUrl:urlString];
    [tempDic setObject:urlString forKey:@"url"];

    [MSActiveControllerFinder sharedFinder].resetStatus();
    UINavigationController *navigator = [MSActiveControllerFinder sharedFinder].activeNavigationController();
    [navigator pushViewControllerClass:NSClassFromString(@"EMWebViewController") params:tempDic];
}

/*
 处理url
    1、去掉重复参数，过滤web的bug
    2、处理黑白版url：黑板添加css=night，白板去掉css=night(如果拿到的 web url包含css=night)
 */
- (NSString *)handleUrl:(NSString *)urlString
{
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:urlString];
    NSMutableDictionary<NSString*, NSURLQueryItem*> *tempDic = [NSMutableDictionary dictionary];

    for (NSURLQueryItem *item in urlComponents.queryItems) {
        [tempDic setObject:item forKey:item.name];
    }

    if ([[MSThemeManager currentTheme] isEqualToString:@"black"]) {
        NSURLQueryItem *item = [[NSURLQueryItem alloc] initWithName:@"css" value:@"night"];
        [tempDic setObject:item forKey:item.name];
    } else {
        if ([tempDic.allKeys containsObject:@"css"]) {
            [tempDic removeObjectForKey:@"css"];
        }
    }
    urlComponents.queryItems = tempDic.allValues;

    return urlComponents.URL.absoluteString;
}

@end

