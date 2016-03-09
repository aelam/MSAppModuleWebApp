//
//  EMWebAppInfo.h
//  EMStock
//
//  Created by ryan on 15/11/24.
//  Copyright © 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMWebAppInfo : NSObject

@property (nonatomic, strong) NSNumber *productID;
@property (nonatomic, strong) NSNumber *platformID;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSNumber *vendorID;
@property (nonatomic, strong) NSString *guid;
@property (nonatomic, strong) NSString *systemVersion;
@property (nonatomic, strong) NSNumber *loginType;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *webAuthToken;

+ (instancetype)shareWebAppInfo;

- (NSDictionary *)appExtraInfo;


@end


// TODO: 最终要在外面处理
@interface EMWebAppInfo (EMStock)

- (void)updateWebAppInfo;

@end