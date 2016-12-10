//
//  MSAppSettingsWebApp.h
//  Pods
//
//  Created by ryan on 3/9/16.
//
//

#import <Foundation/Foundation.h>
#import <MSAppModuleKit/MSAppModuleKit.h>

@protocol EMClickAdapter;

typedef NSDictionary * (^MSWebAppAuthInfo)(void);
typedef BOOL (^MSUserHasZXGHandler)(NSInteger);

@protocol MSAppSettingsWebApp <MSAppSettings>

@property (nonatomic, copy) MSWebAppAuthInfo webAppAuthInfo;

@optional
@property (nonatomic, copy) MSUserHasZXGHandler userHasZXGHandler;
@property (nonatomic, assign) BOOL WKWebViewEnabled; // Default NO
@property (nonatomic, strong) Class<EMClickAdapter> EMClickClass;

@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, assign) NSInteger platformID;
@property (nonatomic, assign) NSInteger vendorID;
@property (nonatomic, strong) NSString *theme;

@end
