//
//  EMAppSettings.h
//  EMStock
//
//  Created by ryan on 15/11/5.
//  Copyright © 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSAppSettings.h"
#import "EMAppBaseInfoSettings.h"
#import "EMSettingsCondition.h"

#if __MODULE_WSPX_ENABLED__
    #import <EMWSPXModule/EMAppSettingsWSPX.h>
#endif /* __MODULE_WSPX_ENABLED__ */

#if __MODULE_MESSAGE_ENABLED__
    #import <MSMessage/MSMessageAppSettings.h>
#endif /* __MODULE_MESSAGE_ENABLED__ */

#if __MODULE_SHARE_ENABLED__
    #import <MSAppModuleShare/EMAppShareSettings.h>
#endif /* __MODULE_SHARE_ENABLED__ */

#if __MODULE_WEB_APP_ENABLED__
    #import <MSAppModuleWebApp/MSAppSettingsWebApp.h>
#endif /* __MODULE_WEB_APP_ENABLED__ */


#if __MODULE_INFO_ENABLED__
    #import <EMInfoKit/EMInfoAppSetting.h>
#endif /* __MODULE_INFO_ENABLED__ */


#if __MODULE_ONLINE_TRADE_ENABLED__

#import <MSAppModuleOnlineTrade/MSAppModuleSettingsOnlineTrade.h>

#endif /* __MODULE_ONLINE_TRADE_ENABLED__ */

@protocol MSAppSettings;
@protocol EMAppBaseInfoSettings;

@interface EMAppSettings : MSAppSettings <EMAppBaseInfoSettings,

#if __MODULE_MESSAGE_ENABLED__
MSMessageAppSettings,
#endif

#if __MODULE_INFO_ENABLED__
EMInfoAppSetting,
#endif

#if __MODULE_WSPX_ENABLED__
EMAppSettingsWSPX,
#endif

#if __MODULE_MESSAGE_ENABLED__
MSMessageAppSettings,
#endif

#if __MODULE_SHARE_ENABLED__
EMAppShareSettings,
#endif

#if __MODULE_WEB_APP_ENABLED__
MSAppSettingsWebApp,
#endif

#if __MODULE_ONLINE_TRADE_ENABLED__
MSAppModuleSettingsOnlineTrade,
#endif

NSObject
>

/* EMAppBaseInfoSettings */
@property (nonatomic, strong, readwrite) NSString* deviceTokenString; // 推送token
@property (nonatomic, strong, readwrite) NSString* tokenErrorString; // token错误信息


@property (nonatomic, assign, readonly) NSInteger appID;      // itunes connect应用号
@property (nonatomic, assign) NSInteger productID;      // itunes connect应用号
@property (nonatomic, assign) NSInteger platformID;      //
@property (nonatomic, assign) NSInteger vendorID;   // 渠道号


#if __MODULE_WSPX_ENABLED__
@property (nonatomic, assign) BOOL wspxEnabled;
@property (nonatomic, assign) BOOL wspxProxyEnabled;
#endif /* EMAppSettingsWSPX */


#if __MODULE_SHARE_ENABLED__
@property (nonatomic, strong) EMSocialDefaultConfigurator *shareConfigurator;
@property (nonatomic, strong) NSString *theme; // white or black
#endif /* EMAppShareSettings */


#if __MODULE_MESSAGE_ENABLED__
@property (nonatomic, strong) NSDictionary *launchOptions;
#endif /* MSMessageAppSettings */

#if __MODULE_WEB_APP_ENABLED__
@property (nonatomic, strong, readwrite) NSString *mainURLScheme;
@property (nonatomic, strong) NSArray *supportsURLSchemes;
@property (nonatomic,   copy) MSWebAppAuthInfo webAppAuthInfo;
@property (nonatomic,  copy) MSUserHasZXGHandler userHasZXGHandler;

#elif __MODULE_ONLINE_TRADE_ENABLED__
@property (nonatomic, strong, readwrite) NSString *mainURLScheme;
#endif /* __MODULE_WEB_APP_ENABLED__ */


+ (BOOL)isAppStoreVersion;

/**
 *参数的本地化存储
 */
- (void)save;

@end

