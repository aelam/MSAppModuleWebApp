//
//  UIWebView+JSExtend.m
//  EMStock
//
//  Created by ryan on 15/8/27.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "UIWebView+JSExtend.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MSAppSettingsWebApp.h"
#import "MSWebAppInfo.h"
#import <EMSpeed/MSCore.h>

//TODO
extern int User_hasStockAtZXG(NSInteger);

@implementation UIWebView (JSExtend)

- (void)loadExtendActions {

    __weak __typeof (self)weakSelf = self;
    JSContext *context = [self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    JSValue *goods = [context objectForKeyedSubscript:@"goods"];
    
    BOOL (^CanOpenURL)(NSString *, NSString *) = ^BOOL(NSString *urlString, NSString *callback) {
        BOOL rs = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]];
        NSString* string = [NSString stringWithFormat:@"%@(%d);",callback,rs];
        [weakSelf stringByEvaluatingJavaScriptFromString:string];

        return rs;
    };
    
    [goods setObject:CanOpenURL forKeyedSubscript:@"canOpenURL"];

    id<MSAppSettingsWebApp> settings = (id<MSAppSettingsWebApp>)[MSAppSettings appSettings];

#if 1
    //
    BOOL (^IsZxg)(NSString *, NSString *callback) = ^BOOL(NSString *stockId, NSString *callback) {
        if (&User_hasStockAtZXG) {
            NSInteger goodsId = [stockId integerValue];
            BOOL isZXG = User_hasStockAtZXG(goodsId);
            NSString* string = [NSString stringWithFormat:@"%@(%d);",callback,isZXG];
            [weakSelf stringByEvaluatingJavaScriptFromString:string];
            return isZXG;
        } else {
            return NO;
        }
    };
    [goods setObject:IsZxg forKeyedSubscript:@"isZxg"];

    //
    NSString *(^getAppInfo)() = ^NSString * () {        
        return [[MSWebAppInfo getWebAppInfoWithSettings:settings] jsonString];
    };
    [goods setObject:getAppInfo forKeyedSubscript:@"getAppInfo"];
#endif
    
}

@end
