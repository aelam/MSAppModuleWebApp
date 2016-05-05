//
//  UIWebView+Context.h
//  Pods
//
//  Created by ryan on 4/27/16.
//
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface UIWebView (Context)

- (JSContext *)javaScriptContext;

@end
