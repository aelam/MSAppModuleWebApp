//
//  MSAppModuleWebApp.m
//  Pods
//
//  Created by ryan on 3/9/16.
//
//

#import "MSAppModuleWebApp.h"
#import "MSAppSettingsWebApp.h"
#import <JLRoutes/JLRoutes.h>
#import "MSActiveControllerFinder.h"
#import "UIViewController+Routes.h"
#import "EMWebViewController.h"

@implementation MSAppModuleWebApp

- (void)moduleDidLoad:(id<MSAppSettingsWebApp>)info {
    [super moduleDidLoad:info];
    
    NSAssert([[info supportsURLSchemes] count] >= 1, @"需要配置`supportsURLSchemes`");
}

- (void)moduleDidUnload:(id<MSAppSettings>)info {
    [super moduleDidUnload:info];
}

- (void)moduleRegisterRoutes:(JLRoutes *)route {

    // open web
    [route addRoute:@"web" handler:^BOOL(NSDictionary * _Nonnull parameters) {
        UINavigationController *navigaionController = [MSActiveControllerFinder finder].activeNavigationController();
        [navigaionController pushViewControllerClass:NSClassFromString(@"EMWebViewController") params:parameters];
        return YES;
    }];
    
    // close
    [route addRoutes:@[@"close", @"back"] handler:^BOOL(NSDictionary * _Nonnull parameters) {
        UINavigationController *navigaionController = [MSActiveControllerFinder finder].activeNavigationController();
        [navigaionController popViewControllerAnimated:YES];

        return YES;
    }];
    
    // webView goback
    [route addRoutes:@[@"goBack", @"goback"] handler:^BOOL(NSDictionary * _Nonnull parameters) {
        EMWebViewController *webViewController = (EMWebViewController *)[MSActiveControllerFinder finder].activeTopController();
        if ([webViewController respondsToSelector:@selector(webView)]) {
            [[webViewController webView] goBack];
        }
        
        return YES;
    }];
    
}

- (void)moduleUnregisterRoutes:(JLRoutes *)route {
    [route removeRoute:@"web"];
}

@end
