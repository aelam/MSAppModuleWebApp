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
    [self addRoute:@"web" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        NSURL *URL = [NSURL URLWithString:parameters[@"url"]];
        NSString *scheme = [URL scheme];
        NSString *lowerScheme = [scheme lowercaseString];
        if ([settings.supportsURLSchemes containsObject:scheme]) {
            return [JLRoutes routeURL:URL];
        } else if ([lowerScheme isEqualToString:@"http"] ||
                   [lowerScheme isEqualToString:@"https"] ||
                   [lowerScheme hasPrefix:@"file"]) {

            // url adapte theme
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
            if ([[MSThemeManager currentTheme] isEqualToString:@"black"]) {
                NSString *urlString = parameters[@"url"];
                if (![urlString containsString:@"css=night"]) {
                    if ([urlString containsString:@"?"]) {
                        urlString = [urlString stringByAppendingString:@"&"];
                    } else {
                        urlString = [urlString stringByAppendingString:@"?"];
                    }
                    urlString = [urlString stringByAppendingString:@"css=night"];
                }
                [tempDic setObject:urlString forKey:@"url"];
            }

            [MSActiveControllerFinder sharedFinder].resetStatus();
            UINavigationController *navigator = [MSActiveControllerFinder sharedFinder].activeNavigationController();
            [navigator pushViewControllerClass:NSClassFromString(@"EMWebViewController") params:tempDic];
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


@end
