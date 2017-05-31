//
//  MSAppSettingsWebApp.h
//  Pods
//
//  Created by ryan on 3/9/16.
//
//

#import <Foundation/Foundation.h>
#import <MSAppModuleKit/MSAppModuleKit.h>

@protocol WebViewLoading

- (void)startLoading;
- (void)stopLoading;

@end


@protocol EMClickAdapter;

typedef NSDictionary * (^MSWebAppAuthInfo)(void);
typedef BOOL (^MSUserHasZXGHandler)(NSInteger);

@protocol MSAppSettingsWebApp <MSAppSettings>

@property (nonatomic, copy) MSWebAppAuthInfo webAppAuthInfo;

@optional
@property (nonatomic, copy) MSUserHasZXGHandler userHasZXGHandler;
@property (nonatomic, assign, readonly) BOOL WKWebViewEnabled;   // Default NO
@property (nonatomic, assign, readonly) BOOL supportsFontChange; // Default NO
@property (nonatomic, strong) Class<EMClickAdapter> EMClickClass;
@property (nonatomic, strong) NSBundle *overrideWebAppImageResouceBundle;

@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, assign) NSInteger platformID;
@property (nonatomic, assign) NSInteger vendorID;
@property (nonatomic, strong) NSString *theme;

@property (nonatomic, strong) Class<WebViewLoading> WebViewLoadingClass;

@end
