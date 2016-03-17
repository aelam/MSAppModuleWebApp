//
//  JLRoutes+WebApp.m
//  Pods
//
//  Created by ryan on 3/17/16.
//
//

#import "JLRoutes+WebApp.h"
#import <BDKNotifyHUD.h>
#import <UIViewController+Routes.h>

#import "MSActiveControllerFinder.h"
#import "EMWebViewController.h"

@implementation JLRoutes (WebApp)

- (void)registerRoutesForWebApp {
    [self registerCopy];
    [self registerCanOpenURL];
    [self registerShowNotify];
    [self registerWeb];
    [self registerGoBack];
    [self registerPop];
}

- (void)registerCopy {
    [self addRoute:@"copy" handler:^BOOL(NSDictionary *parameters) {
        NSString *text = parameters[@"text"];
        UIPasteboard *p = [UIPasteboard generalPasteboard];
        [p setString:text];
        return YES;
    }];
}

- (void)registerCanOpenURL
{
    __weak __typeof(self)weakSelf = self;
    // search
    [self addRoute:@"canOpenURL" handler:^BOOL(NSDictionary *parameters) {
        NSString *url = parameters[@"appurl"];
        NSString *callback = parameters[@"callback"];
        
        BOOL canopen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
        
        EMWebViewController *webViewController = (EMWebViewController *)[MSActiveControllerFinder finder].activeTopController();
        if ([webViewController respondsToSelector:@selector(webView)]) {
            NSString *callbackStr = [NSString stringWithFormat:@"%@(\"%d\")",callback,canopen];
            [webViewController.webView stringByEvaluatingJavaScriptFromString:callbackStr];
        }
        return YES;
    }];
}

- (void)registerShowNotify {
    [self addRoute:@"showNotify" handler:^BOOL(NSDictionary *parameters) {
        NSString *message = parameters[@"message"];
        [BDKNotifyHUD showNotifHUDWithText:message];
        return YES;
    }];
}

- (void)registerWeb {
    __weak __typeof(self)weakSelf = self;
    [self addRoute:@"web" handler:^BOOL(NSDictionary *parameters) {
        UINavigationController *navController = [MSActiveControllerFinder finder].activeNavigationController();
        [MSActiveControllerFinder finder].resetStatus();
        [navController pushViewControllerClass:NSClassFromString(@"EMWebViewController") params:parameters];
        
        return YES;
    }];
}

/**
 *  注册网页返回`goBack`
 */
- (void)registerGoBack {
    // 网页返回
    // 保证WebViewController 有webview属性
    __weak __typeof(self)weakSelf = self;
    BOOL (^completion)(NSDictionary *) = ^BOOL(NSDictionary *parameters) {
        EMWebViewController *webViewController = (EMWebViewController *)[MSActiveControllerFinder finder].activeTopController();
        if ([webViewController respondsToSelector:@selector(webView)]) {
            [[webViewController webView] goBack];
        }
        return YES;
    };
    
    [self addRoutes:@[@"goBack", @"goback"] handler:completion];
}

/**
 *  注册页面pop `pop`
 *  注册页面close `close` // 关闭网页
 */
- (void)registerPop {
    // 页面pop
    __weak __typeof(self)weakSelf = self;
    
    BOOL (^completion)(NSDictionary *) = ^BOOL(NSDictionary *parameters) {
        UINavigationController *navController = [MSActiveControllerFinder finder].activeNavigationController();
        BOOL animated = YES;
        if (parameters[@"animated"]) {
            animated = [parameters[@"animated"] boolValue];
        }
        
        [navController popViewControllerAnimated:animated];
        return YES;
    };
    
    [self addRoutes:@[@"close", @"back"] handler:completion];

}

- (void)unregisterRoutesForWebApp {
    
}


@end
