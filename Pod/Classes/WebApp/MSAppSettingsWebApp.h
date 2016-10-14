//
//  MSAppSettingsWebApp.h
//  Pods
//
//  Created by ryan on 3/9/16.
//
//

#import <Foundation/Foundation.h>
#import <MSAppModuleKit/MSAppModuleKit.h>

typedef NSDictionary *(^MSWebAppAuthInfo)(void);
typedef BOOL (^MSUserHasZXGHandler)(NSInteger);

@protocol MSAppSettingsWebApp <MSAppSettings>

@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, assign) NSInteger platformID;
@property (nonatomic, assign) NSInteger vendorID;

@property (nonatomic, strong) NSString *theme;
@property (nonatomic, strong) NSArray *supportsURLSchemes;
@property (nonatomic, strong, readonly) NSString *mainURLScheme;

@property (nonatomic,  copy) MSWebAppAuthInfo webAppAuthInfo;
@property (nonatomic,  copy) MSUserHasZXGHandler userHasZXGHandler;

@end
