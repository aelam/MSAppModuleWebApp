//
//  EMSocialSDK+URLBind.h
//  StockMaster
//
//  Created by Ryan Wang on 6/3/15.
//  Copyright (c) 2015 Emoney. All rights reserved.
//

#import "EMSocialSDK.h"
#import "EMShareEntity.h"

@class EMShareEntity;

extern NSString *const EMShareTitleKey;   // NSString
extern NSString *const EMShareContentKey; // NSString
extern NSString *const EMShareURLKey;     // NSString
extern NSString *const EMShareIconUrlKey; // NSString
extern NSString *const EMShareImageUrlKey;// NSString
extern NSString *const EMShareIconKey;    // UIImage
extern NSString *const EMShareImageKey;   // UIImage
extern NSString *const EMSharePlatformTypeKey;   // NSString



@interface EMSocialSDK (URLBind)

+ (void)setDefaultShareImage:(UIImage *)image;
- (UIImage *)defaultShareImage; // [UIImage imageNamed:@"AppIcon60x60"];

- (void)shareEntity:(EMShareEntity *)shareEntity rootViewController:(UIViewController *)controller completionHandler:(EMActivityShareCompletionHandler)shareCompletionHandler;

/**
 *  通过URL参数调用分享
 *
 *  @param parameters             @{iconUrl, imageUrl, id, title, content, icon}
 *  @param controller             用它present分享controller
 *  @param shareCompletionHandler 分享结果通过handler返回
 */

- (void)shareWithParameters:(NSDictionary *)parameters rootViewController:(UIViewController *)controller completionHandler:(EMActivityShareCompletionHandler)shareCompletionHandler;


@end
