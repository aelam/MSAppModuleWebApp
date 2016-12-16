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

@implementation JLRoutes (WebApp)

- (void)registerRoutesForWebApp {
    [self registerWeb];
    [self registerGoBack];
}

- (void)registerWeb {
    [self registerRoute:@"web" pushingControllerName:@"EMWebViewController"];
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


- (void)unregisterRoutesForWebApp {
    [self removeRoute:@"web"];
    [self removeRoute:@"goBack"];
    [self removeRoute:@"goback"];
}


@end
