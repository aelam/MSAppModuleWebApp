//
//  JSBridgeModuleBase.m
//  Pods
//
//  Created by ryan on 5/4/16.
//
//

#import "JSBridgeModuleBase.h"
#import "JSBridge.h"
#import "JSBridgeModule.h"

#import "MSAppSettingsWebApp.h"
#import "EMWebViewController.h"
#import "BDKNotifyHUD.h"
#import <JLRoutes/JLRoutes.h>
#import "MSCustomMenuItem.h"

#import "EMShareEntity.h"
#import "EMShareEntity+Parameters.h"

#import "WebFontSizeChangeSupport.h"

@implementation JSBridgeModuleBase

@synthesize bridge = _bridge;

JS_EXPORT_MODULE();

- (NSUInteger)priority {
    return JSBridgeModulePriorityHigh;
}

- (NSString *)moduleSourceFile {
    return [[NSBundle bundleForClass:[self class]] pathForResource:@"EMJSBridge" ofType:@"js"];
}

- (void)attachToJSBridge:(JSBridge *)bridge {

    [self registerShowMenuItemsWithBridge:bridge];

    [self registerLogWithBridge:bridge];
    
    [self registerGetAppInfoWithBridge:bridge];
    [self registerCopyWithBridge:bridge];
    [self registerShowNotifyWithBridge:bridge];
    [self registerPopWithBridge:bridge];
    [self registerGoBackWithBridge:bridge];

    [self registerShareConfigWithBridge:bridge];
    [self registerShareWithBridge:bridge];
    [self registerSearchToggleWithBridge:bridge];

    [self registerRouteWithBridge:bridge];
    [self registerUpdateTitleWithBridge:bridge];
    [self registerOpenURLWithBridge:bridge];


    [self registerShowChangeFontSizeViewWithBridge:bridge];
}

- (void)registerShowMenuItemsWithBridge:(JSBridge *)bridge {
    
    __weak EMWebViewController *webViewController = (EMWebViewController *)bridge.viewController;
    [self registerHandler:@"showMenuItems" handler:^(id data, WVJBResponseCallback responseCallback) {
        if (![webViewController respondsToSelector:@selector(setMenuItems:)]) {
            return;
        }
        NSDictionary *parameters  = data;
        if ([parameters isKindOfClass:[NSString class]]) {
            NSData *jsondata = [data dataUsingEncoding:NSUTF8StringEncoding];
            NSError *jsonError = nil;
            parameters = [NSJSONSerialization JSONObjectWithData:jsondata options:kNilOptions error:&jsonError];
        }
        NSArray *menuItems = parameters[@"menuItems"];
        webViewController.menuItems = [MSCustomMenuItem itemsWithData:menuItems];
    }];
}

- (void)registerLogWithBridge:(JSBridge *)bridge {
    [self registerHandler:@"log" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"Log: %@", data);
    }];
}

- (void)registerGetAppInfoWithBridge:(JSBridge *)bridge {
    [self registerHandler:@"getAppInfo2" handler:^(id data, WVJBResponseCallback responseCallback) {
        id<MSAppSettingsWebApp> settings = (id<MSAppSettingsWebApp>)[MSAppSettings appSettings];
        if (settings.webAppAuthInfo) {
            NSDictionary *info = settings.webAppAuthInfo();
            responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess),
                               JSResponseErrorDataKey:info});
        } else {
            responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeFailed)});
        }
    }];
}

- (void)registerCopyWithBridge:(JSBridge *)bridge {
    [self registerHandler:@"copy" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *text = data[@"text"];
        UIPasteboard *p = [UIPasteboard generalPasteboard];
        [p setString:text];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    }];
}


- (void)registerShareWithBridge:(JSBridge *)bridge {
    // "title": title,
    // "url": url,
    // "id": id,
    // "imageurl": imageurl,
    // "iconUrl": iconUrl,
    // "content": content,
    // "type": type,
    // "callback": callback
    
    __weak EMWebViewController *webViewController = (EMWebViewController *)bridge.viewController;
    
    [self registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"share called: %@", data);
        NSDictionary *parameters = (NSDictionary *)data;
        
        if ([webViewController respondsToSelector:@selector(share:)]) {
            EMShareEntity *shareEntity = [EMShareEntity shareEntityWithParameters:parameters];
            [webViewController share:shareEntity];
        }
        
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    }];
}

- (void)registerShareConfigWithBridge:(JSBridge *)bridge {
    __weak EMWebViewController *webViewController = (EMWebViewController *)bridge.viewController;
    [self registerHandler:@"shareConfig" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"shareConfig called: %@", data);
        NSDictionary *parameters = (NSDictionary *)data;
        if ([webViewController respondsToSelector:@selector(setIsShareItemEnabled:)]) {
            BOOL showsShare = [parameters[@"shareToggle"] boolValue];
            if ([webViewController respondsToSelector:@selector(setIsShareItemEnabled:)]) {
                [webViewController setIsShareItemEnabled:showsShare];
            }
        }
        
        if ([webViewController respondsToSelector:@selector(setShareEntity:)]) {
            EMShareEntity *shareEntity = [EMShareEntity shareEntityWithParameters:parameters];
            [webViewController setShareEntity:shareEntity];
        }
        
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    }];
}

- (void)registerShowNotifyWithBridge:(JSBridge *)bridge {
    [self registerHandler:@"showNotify" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *message = data[@"message"];
        [BDKNotifyHUD showNotifHUDWithText:message];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    }];
}


- (void)registerPopWithBridge:(JSBridge *)bridge {
    __weak EMWebViewController *webViewController = (EMWebViewController *)bridge.viewController;

    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        BOOL animated = YES;
        if (parameters[@"animated"]) {
            animated = [parameters[@"animated"] boolValue];
        }
        [webViewController.navigationController popViewControllerAnimated:animated];
        
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    
    [self registerHandler:@"close" handler:handler];
    [self registerHandler:@"back" handler:handler];
    
}

- (void)registerGoBackWithBridge:(JSBridge *)bridge {
    __weak EMWebViewController *webViewController = (EMWebViewController *)bridge.viewController;
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        
        if ([webViewController respondsToSelector:@selector(webView)]) {
            [[webViewController webView] x_goBack];
        }
        
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"goback" handler:handler];
    [self registerHandler:@"goBack" handler:handler];
}

- (void)registerSearchToggleWithBridge:(JSBridge *)bridge {
    __weak EMWebViewController *webViewController = (EMWebViewController *)bridge.viewController;
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        BOOL showsSearch = [parameters[@"searchToggle"] boolValue];
        if ([webViewController respondsToSelector:@selector(setIsSearchItemEnabled:)]) {
            [webViewController setIsSearchItemEnabled:showsSearch];
        }
        
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"searchConfig" handler:handler];
}


- (void)registerRouteWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        NSString *path = parameters[@"path"];
        if (path) {
            [JLRoutes routeURL:[NSURL URLWithString:path] withParameters:parameters];
            responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
        } else {
            responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeFailed)});
        }
    };
    
    [self registerHandler:@"route" handler:handler];
    
}


// Base
- (void)registerUpdateTitleWithBridge:(JSBridge *)bridge {
    __weak UIViewController *viewController = bridge.viewController;
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        NSString *title = parameters[@"title"];
        viewController.title = title;
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"updateTitle" handler:handler];
}

- (void)registerOpenURLWithBridge:(JSBridge *)bridge {
    __weak UIViewController *viewController = bridge.viewController;
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        
        EMWebViewController *webViewController = [[EMWebViewController alloc] initWithRouterParams:parameters];
        
        [viewController.navigationController pushViewController:webViewController animated:YES];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"web" handler:handler];
}

- (void)registerShowChangeFontSizeViewWithBridge:(JSBridge *)bridge {
    __weak UIViewController <WebFontSizeChangeSupport> *viewController = bridge.viewController;
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        
        [viewController showChangeFontSizeViewWithSelection:^(NSString *newFontSize) {
            responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess),
                               @"fontSize":newFontSize});
        }];
    };
    
    [self registerHandler:@"showChangeFontSizeView" handler:handler];
}

@end
