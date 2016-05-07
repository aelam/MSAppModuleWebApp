//
//  EMSocialSDK+URLBind.m
//  StockMaster
//
//  Created by Ryan Wang on 6/3/15.
//  Copyright (c) 2015 Emoney. All rights reserved.
//

#import "EMSocialSDK+URLBind.h"
#import <SDWebImage/SDWebImageManager.h>
#import <EMSocialKit/EMSocialSDK.h>

NSString *const EMSharePlatformTypeKey  = @"id";
NSString *const EMShareTitleKey         = @"title";
NSString *const EMShareContentKey       = @"content";
NSString *const EMShareURLKey           = @"url";
NSString *const EMShareIconUrlKey       = @"iconUrl";
NSString *const EMShareImageUrlKey      = @"imageUrl";
NSString *const EMShareImageKey         = @"image";
NSString *const EMShareIconKey          = @"icon";


@implementation EMSocialSDK (URLBind)

static UIImage *defaultShareImage = nil;

+ (void)load {
    defaultShareImage = [UIImage imageNamed:@"AppIcon60x60"];
}

+ (void)setDefaultShareImage:(UIImage *)image {
    defaultShareImage = image;
}

- (UIImage *)defaultShareImage {
    if (defaultShareImage) {
        return defaultShareImage;
    }
    return [UIImage imageNamed:@"AppIcon60x60"];
}

- (void)shareEntity:(EMShareEntity *)shareEntity rootViewController:(UIViewController *)controller completionHandler:(EMActivityShareCompletionHandler)shareCompletionHandler {
    
    NSMutableDictionary *shareParameters = [NSMutableDictionary dictionary];
    if(shareEntity.shareTitle) {
        shareParameters[EMShareTitleKey] = shareEntity.shareTitle;
    }
    if(shareEntity.shareDescription) {
        shareParameters[EMShareContentKey] = shareEntity.shareDescription;
    }
    
    if(shareEntity.iconUrl) {
        shareParameters[EMShareIconUrlKey] = shareEntity.iconUrl;
    }

    if(shareEntity.shareImageUrl) {
        shareParameters[EMShareImageUrlKey] = shareEntity.shareImageUrl;
    }
    if(shareEntity.shareImage) {
        shareParameters[EMShareImageKey] = shareEntity.shareImage;
    }
    if(shareEntity.shareTitle) {
        shareParameters[EMShareTitleKey] = shareEntity.shareTitle;
    }
    
    if (shareEntity.shareUrl) {
        shareParameters[EMShareURLKey] = shareEntity.shareUrl;
    }
    if(shareEntity.iconImage) {
        shareParameters[EMShareIconKey] = shareEntity.iconImage;
    }
    
    if (shareEntity.socialType) {
        shareParameters[EMSharePlatformTypeKey] = @(shareEntity.socialType);
    }
    
    [self shareWithParameters:shareParameters rootViewController:controller completionHandler:shareCompletionHandler];
}

- (void)shareWithParameters:(NSDictionary *)parameters rootViewController:(UIViewController *)controller completionHandler:(EMActivityShareCompletionHandler)shareCompletionHandler {
    NSMutableDictionary *newParameters = [parameters mutableCopy];
    UIImage *appIcon = parameters[EMShareIconKey];
    if (appIcon == nil) {
        appIcon = [self defaultShareImage];
    }
    
    if (appIcon) {
        newParameters[EMShareIconKey] = appIcon;
    }
    
    UIImage *image = newParameters[EMShareImageKey];
    if (image) {
        [self _shareWithParamters:newParameters rootViewController:controller completionHandler:shareCompletionHandler];
    } else {
        // 需要下载图片
        // iconUrl非icon得url
        // iconUrl与imageUrl只会出现一个
        // 现在web默认情况都会传iconUrl
        NSString *iconUrl = newParameters[EMShareIconUrlKey];
        if (iconUrl.length == 0) {
            iconUrl = newParameters[EMShareImageUrlKey];
        }
        
        if (iconUrl) {
            [[SDWebImageManager sharedManager] downloadImageWithURL: [NSURL URLWithString: iconUrl] options: SDWebImageHighPriority progress: nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
             {
                 NSMutableDictionary *newPamaters = [NSMutableDictionary dictionaryWithDictionary:parameters];
                 [newPamaters setObject:image forKey:EMShareImageKey];
                 
                 [self _shareWithParamters:newPamaters rootViewController:controller completionHandler:shareCompletionHandler];
             }];
        }
        else
        {
            [self _shareWithParamters:newParameters rootViewController:controller completionHandler:shareCompletionHandler];
        }
    }
}

- (void)_shareWithParamters:(NSDictionary *)parameters rootViewController:(UIViewController *)controller completionHandler:(EMActivityShareCompletionHandler)shareCompletionHandler {

    NSInteger shareType = [parameters[EMSharePlatformTypeKey] integerValue]; // 0 为选择列表

    NSArray *activityItems = [self activityItemWithParameters:parameters];
    
    if (shareType == EMSocialTypeAll) {
        [self shareActivityItems:activityItems rootViewController:controller completionHandler:shareCompletionHandler];
    } else if (shareType == EMSocialTypeWeChat){
        [self shareActivityItems:activityItems activity:[[EMActivityWeChatSession alloc] init] completionHandler:shareCompletionHandler];
    } else if (shareType == EMSocialTypeMoments) {
        [self shareActivityItems:activityItems activity:[[EMActivityWeChatTimeline alloc] init] completionHandler:shareCompletionHandler];
    } else if (shareType == EMSocialTypeSinaWeibo) {
        [self shareActivityItems:activityItems activity:[[EMActivityWeibo alloc] init] completionHandler:shareCompletionHandler];
    }
}

- (NSArray *)activityItemWithParameters:(NSDictionary *)parameters {
    NSString *title = parameters[EMShareTitleKey];
    NSString *content = parameters[EMShareContentKey];
    NSString *url = parameters[EMShareURLKey];
    UIImage *image = parameters[EMShareImageKey];
    UIImage *icon = parameters[EMShareIconKey];
    
    NSMutableArray *items = [NSMutableArray array];
    if (title) {
        [items addObject:title];
    }
    if (content) {
        [items addObject:content];
    }
    
    if (image) {
        [items addObject:image];
    }
    
    // wechat 有一个thumbData 通过dictionary传入
    // weibo 忽略icon
    NSMutableDictionary *appendInfo = [NSMutableDictionary dictionary];
//    if (content) {
//        [appendInfo setObject:content forKey:EMActivityWeChatDescriptionKey];
//    }
    if (icon) {
        [appendInfo setObject:icon forKey:EMActivityWeChatThumbImageKey];
    }
    if ([appendInfo count]) {
        [items addObject:appendInfo];
    }

    
    url = [url stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *URL = [NSURL URLWithString:url];
    if (URL) {
        [items addObject:URL];
    }

    return items;
}

@end
