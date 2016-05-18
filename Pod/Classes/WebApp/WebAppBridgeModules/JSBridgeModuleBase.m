//
//  JSBridgeModuleBase.m
//  Pods
//
//  Created by ryan on 5/4/16.
//
//

#import "JSBridgeModuleBase.h"
#import "JSBridge.h"
#import "MSAppSettingsWebApp.h"
#import "MSWebAppInfo.h"
#import "EMShareEntity.h"
#import "EMWebViewController.h"
#import "BDKNotifyHUD.h"
#import "JSBridgeModule.h"
#import <JLRoutes/JLRoutes.h>
#import "MSCustomMenuItem.h"

@implementation JSBridgeModuleBase

@synthesize bridge = _bridge;

JS_EXPORT_MODULE();

- (NSString *)moduleSourceFile {
    return [[NSBundle bundleForClass:[self class]] pathForResource:@"EMJSBridge" ofType:@"js"];
}

- (void)attachToJSBridge:(JSBridge *)bridge {

    [self registerShowMenuItemsWithBridge:bridge];

    [self registerLogWithBridge:bridge];
    
    [self registerGetAppInfoWithBridge:bridge];
    [self registerCopyWithBridge:bridge];
    [self registerCanOpenURL2WithBridge:bridge];
    [self registerShowNotifyWithBridge:bridge];
    [self registerPopWithBridge:bridge];
    [self registerGoBackWithBridge:bridge];

    [self registerShareConfigWithBridge:bridge];
    [self registerShareWithBridge:bridge];
    [self registerSearchToggleWithBridge:bridge];

//    [self registerShowGoodsWithBridge:bridge];
    [self registerOpenPageWithBridge:bridge];
    [self registerRoutePageWithBridge:bridge];
    [self registerRouteWithBridge:bridge];
    
    [self registerHeightChangeWithBridge:bridge];
    [self registerLoginWithBridge:bridge];
    
    [self registerSearchWithBridge:bridge];
    [self registerUpdateUserInfoWithBridge:bridge];
    
    [self registerUpdateTitleWithBridge:bridge];

}

- (void)registerShowMenuItemsWithBridge:(JSBridge *)bridge {
    
    __weak EMWebViewController *webViewController = (EMWebViewController *)bridge.viewController;
    [self registerHandler:@"showMenuItems" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"showMenuItems: %@", data);
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
        NSDictionary *info = [MSWebAppInfo getWebAppInfoWithSettings:settings];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess),
                           JSResponseErrorDataKey:info});
    }];
}

- (void)registerCanOpenURL2WithBridge:(JSBridge *)bridge {
    [self registerHandler:@"canOpenURL2" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *parameters = (NSDictionary *)data;
        NSString *url = parameters[@"appurl"];
        
        BOOL canopen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
        
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess),
                           JSResponseErrorDataKey:@(canopen)});
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
    __weak EMWebViewController *webViewController = (EMWebViewController *)bridge.viewController;
    
    [self registerHandler:@"share" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"share called: %@", data);
        NSDictionary *parameters = (NSDictionary *)data;
        
        NSString *title = parameters[@"title"];
        NSString *content = parameters[@"content"];
        NSString *postUrl = parameters[@"url"];
        NSString *imageUrl = parameters[@"imageurl"];
        NSString *iconUrl = parameters[@"iconUrl"];
        
        NSInteger socialType = [parameters[@"id"] integerValue];
        NSString *callback = parameters[@"callback"];
        
        EMShareEntity *shareEntity = [[EMShareEntity alloc] initShareEntityTitle:title Description:content Image:nil Url:postUrl ImageUrl:imageUrl];
        shareEntity.iconUrl = iconUrl;
        shareEntity.socialType = socialType;
        shareEntity.callback = callback;

        if ([webViewController respondsToSelector:@selector(share:)]) {
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
            UIImage *appIcon = [UIImage imageNamed:@"AppIcon60x60"];
            NSString *title = parameters[@"title"];
            NSString *content = parameters[@"content"];
            NSString *postUrl = parameters[@"url"];
            NSString *imageUrl = parameters[@"imageurl"];
            NSInteger socialType = [parameters[@"id"] integerValue];
            NSString *callback = parameters[@"callback"];
            
            EMShareEntity *shareEntity = [[EMShareEntity alloc] initShareEntityTitle:title Description:content Image:appIcon Url:postUrl ImageUrl:imageUrl];
            shareEntity.callback = callback;
            shareEntity.socialType = socialType;
            
            if ([webViewController respondsToSelector:@selector(setShareEntity:)]) {
                [webViewController setShareEntity:shareEntity];
            }
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

#pragma mark - JLRoutes跳转
// page
- (void)registerOpenPageWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"page"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"page" handler:handler];
    
}

- (void)registerRoutePageWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"page"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"routePage" handler:handler];
    
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


//// showgoods
//- (void)registerShowGoodsWithBridge:(JSBridge *)bridge {
//    [self registerHandler:@"showgoods" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSDictionary *parameters = (NSDictionary *)data;
//        [JLRoutes routeURL:[NSURL URLWithString:@"showgoods"] withParameters:parameters];
//        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
//    }];
//}

- (void)registerCheckTaskStatusWithBridge:(JSBridge *)bridge {
    [self registerHandler:@"checkTaskStatus" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"checkTaskStatus"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    }];
}

// openAccount
//- (void)registerOpenAccountWithBridge:(JSBridge *)bridge {
//    __typeof(self)weakSelf = self;
//    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
//        NSDictionary *parameters = (NSDictionary *)data;
//        [JLRoutes routeURL:[NSURL URLWithString:@"openAccount"] withParameters:parameters];
//        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
//    };
//    
//    [self registerHandler:@"openAccount" handler:handler];
//    
//}

//// 移到社区
//// commentList
//- (void)registerOpenCommentListWithBridge:(JSBridge *)bridge {
//    __typeof(self)weakSelf = self;
//    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
//        NSDictionary *parameters = (NSDictionary *)data;
//        [JLRoutes routeURL:[NSURL URLWithString:@"commentList"] withParameters:parameters];
//        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
//    };
//    
//    [self registerHandler:@"commentList" handler:handler];
//    
//}


- (void)registerHeightChangeWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"heightChange"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
//    [self registerHandler:@"heightChange" handler:handler];
}

- (void)registerLoginWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"login"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"login" handler:handler];
}

- (void)registerUpdateUserInfoWithBridge:(JSBridge *)bridge {
//    __typeof(self)weakSelf = self;
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"updateUserInfo"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"updateUserInfo" handler:handler];
}

// 移到search
- (void)registerSearchWithBridge:(JSBridge *)bridge {
    void (^handler)(id, WVJBResponseCallback) = ^(id data, WVJBResponseCallback responseCallback){
        NSDictionary *parameters = (NSDictionary *)data;
        [JLRoutes routeURL:[NSURL URLWithString:@"search"] withParameters:parameters];
        responseCallback(@{JSResponseErrorCodeKey:@(JSResponseErrorCodeSuccess)});
    };
    
    [self registerHandler:@"search" handler:handler];
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


@end
