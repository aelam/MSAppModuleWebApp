//
//  ymActionWebViewController.h
//  ymActionWebView
//
//  Created by flora on 14-7-3.
//  Copyright (c) 2014年 flora. All rights reserved.
//
//
//1、加载网页
//2、可通过设置synchronizeDocumentTitle = yes，同步在导航栏显示当前页面的标题，默认是yes
//3、可通过各接口加载url、request、htmlstring
//4、支持js事件
//5、处理tel以及sms事件
//6、自定义返回控件，可控制页面内返回事件。用户点击返回按键执行网页后退一次后，增加关闭按键，可通过关闭按键退出当前controller
//

#import <UIKit/UIKit.h>
#import <MSRoutes/MSRoutes.h>
#import "WebShareSupport.h"
#import "WebSearchSupport.h"
#import "WebFontSizeChangeSupport.h"

typedef NS_ENUM (NSInteger, EMFontSizeType) {
    EMFontSizeTypeSmall,
    EMFontSizeTypeMiddle,
    EMFontSizeTypeBig
};


@class MSMenuItemData;
@class EMWebBackView;
@class EMShareEntity;

@protocol UIViewControllerRoutable;
@protocol XWebView;
@protocol MSAppSettingsWebApp;

@interface EMWebViewController : UIViewController <UIViewControllerRoutable, WebShareSupport, WebSearchSupport, WebFontSizeChangeSupport>

@property (nonatomic, assign) BOOL synchronizeDocumentTitle; // navbar同步页面document的title，default is `YES`

@property (nonatomic, strong, readonly) UIView<XWebView> *webView;
@property (nonatomic, assign, getter = isCloseButtonShown) BOOL showsCloseButton; // Default YES

// Share Supports
@property (nonatomic, strong) EMShareEntity *shareEntity;
@property (nonatomic, assign) BOOL isShareItemEnabled;

// Search Supports
@property (nonatomic, assign) BOOL isSearchItemEnabled;

// Font Change Supports
@property (nonatomic, assign) BOOL supportsFontChange;
@property (nonatomic, assign) BOOL isFontChangeItemEnabled;
@property (nonatomic, strong) NSNumber *fontSize;
@property (nonatomic, copy) void (^fontSizeSelection) (NSString *fontSize);

- (void)showChangeFontSizeViewWithSelection:(void (^)(NSInteger))selection;

// JSMenuItems
@property (nonatomic, strong) NSArray <MSMenuItemData *> *menuItems;

// WebAppSettings
+ (void)setModuleSettings:(id<MSAppSettingsWebApp>)moduleSettings;
+ (id<MSAppSettingsWebApp>)moduleSettings;



- (instancetype)initWithURL:(NSURL *)URL;
- (instancetype)initWithRequest:(NSURLRequest *)request;

- (NSURL *)URL;

- (void)openURL:(NSURL *)URL;
- (void)openRequest:(NSURLRequest *)request;
- (void)openHTMLString:(NSString *)htmlString baseURL:(NSURL *)baseUrl;


+ (Class)webViewClass; // 子类重写

- (void)doRefresh;

- (void)share:(EMShareEntity *)shareEntity;


// 通过JLRoutes跳转的时候 可附加eventAttributes 会传入统计中去
@property (nonatomic, strong) NSDictionary *eventAttributes;

@end
