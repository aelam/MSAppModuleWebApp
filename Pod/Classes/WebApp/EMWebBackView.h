//
//  EMWebBackView.h
//  ymActionWebView
//
//  Created by flora on 14-7-3.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

/**支持webview的返回切换
 *支持controller的返回切换
 */
@interface EMWebBackView : UIButton
{
}

@property (nonatomic, readonly, strong) UIButton *closeButton;  //关闭按键

/**是否支持关闭功能
 *支持关闭功能：默认有返回按键，用户点击一次返回后，显示关闭按键
 *不支持关闭功能：仅当webview有需求时才显示返回按键
 */
@property (nonatomic, assign) BOOL supportClose;
@property (nonatomic, assign) BOOL showGoBack;

- (id)initWithParamSupportClose:(BOOL)supportClose;

/**增加点击事件处理
 *target:事件处理target
 *backAction:返回事件处理
 *closeAction:关闭事件处理
 */
- (void)addTarget:(id)target
       backAction:(SEL)backAction
      closeAction:(SEL)closeAction
 forControlEvents:(UIControlEvents)controlEvents;

/**根据当前webview的加载状况，更新按键状态
 */
//- (void)updateWithCurrentWebView:(UIWebView *)webView;
- (void)goBack;

//- (void)updateWithCanGoBack:(BOOL)canGoBack;

@end
