//
//  UIWebView+jsToObject.h
//  ymActionWebView
//
//  Created by flora on 14-7-4.
//  Copyright (c) 2014年 flora. All rights reserved.
//
//
//
//
//

#import <UIKit/UIKit.h>

@interface UIWebView (jsToObject)

/**执行一段本地的js脚本，使得本地处理js事件。
 *请在代理方法 webViewDidFinishLoad 中执行
 *先从document文件中读取js指定js问题
 *如果读取失败，从本地bundle中重新获取一次
 *当前webview执行这段脚本
 */
- (void)loadActionJavaScript;

@end
