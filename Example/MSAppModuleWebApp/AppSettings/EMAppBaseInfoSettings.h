//
//  EMAppBaseInfoSettings.h
//  EMStock
//
//  Created by ryan on 15/11/5.
//  Copyright © 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSAppSettings.h"


@protocol MSAppSettings;

@protocol EMAppBaseInfoSettings <MSAppSettings>

@property (nonatomic, assign, readonly) NSInteger appID;      // iTunes connect应用号
@property (nonatomic, assign, readonly) NSInteger productID;  // 产品号
@property (nonatomic, assign, readonly) NSInteger platformID; // 平台号
@property (nonatomic, assign, readwrite) NSInteger vendorID;   // 渠道号

@property (nonatomic, strong, readwrite) NSString *theme;     // 主题色 white/black
@property (nonatomic, strong, readwrite) NSString *mainURLScheme;

// token先放这里, 待放入推送模块中
@property (nonatomic, strong, readwrite) NSString* deviceTokenString; // 推送token
@property (nonatomic, strong, readwrite) NSString* tokenErrorString; // token错误信息

@end


