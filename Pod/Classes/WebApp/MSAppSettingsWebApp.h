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

@protocol MSAppSettingsWebApp <MSAppSettings>

@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, assign) NSInteger platformID;
@property (nonatomic, assign) NSInteger vendorID;
@property (nonatomic, assign) NSInteger loginType;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *webAuthToken;

@property (nonatomic, strong) NSArray *supportsURLSchemes;

@property (nonatomic,  copy) MSWebAppAuthInfo webAppAuthInfo;

@end
