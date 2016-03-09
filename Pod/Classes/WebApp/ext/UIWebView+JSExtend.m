//
//  UIWebView+JSExtend.m
//  EMStock
//
//  Created by ryan on 15/8/27.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "UIWebView+JSExtend.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "EMWebAppInfo.h"

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
    
    //
    BOOL (^IsZxg)(NSString *, NSString *callback) = ^BOOL(NSString *stockId, NSString *callback) {
        NSInteger goodsId = [stockId integerValue];
        BOOL isZXG = User_hasStockAtZXG(goodsId);
        NSString* string = [NSString stringWithFormat:@"%@(%d);",callback,isZXG];
        [weakSelf stringByEvaluatingJavaScriptFromString:string];
        return isZXG;
    };
    [goods setObject:IsZxg forKeyedSubscript:@"isZxg"];

    //
    NSString *(^getAppInfo)() = ^NSString * () {
        return [[[EMWebAppInfo shareWebAppInfo] appExtraInfo] jsonString];;
    };
    [goods setObject:getAppInfo forKeyedSubscript:@"getAppInfo"];

}

@end
