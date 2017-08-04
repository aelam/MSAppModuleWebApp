//
//  XWebViewController.h
//  Pods
//
//  Created by ryan on 03/08/2017.
//
//

#import <Foundation/Foundation.h>

@protocol XWebViewController <NSObject>

@property (nonatomic, strong, readonly) UIView<XWebView> *webView;

@end
