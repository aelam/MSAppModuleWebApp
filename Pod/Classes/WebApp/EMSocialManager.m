//
//  EMSocialManager.h
//  Pods
//
//  Created by Allen on 10/04/2017.
//
//

#import "EMSocialManager.h"
#import <EMSocialKit/EMSocialKit.h>
#import <MSAppModuleShare/EMShareEntity.h>
#import <MSAppModuleWebApp/EMShareEntity+Parameters.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import <SDWebImage/SDWebImageManager.h>
#import <EMSocialKit/EMActivityQQ.h>
#import <EMSocialKit/EMActivityWeibo.h>
#import <EMSocialKit/EMActivityWeChat.h>
#import <EMSocialKit/EMActivityWeChatSession.h>
#import <EMSpeed/BDKNotifyHUD.h>
#import <MSAppModuleWebApp/XWebView.h>
#import <MSAppModuleWebApp/EMWebViewController.h>

typedef NS_ENUM(NSUInteger, EMShareType) {
    EMShareTypeWechat = 1 << 0,
    EMShareTypeMoments = 1 << 1,
    EMShareTypeSina = 1 << 2,
    EMShareTypeQQ = 1 << 3
};

@implementation EMSocialManager

+ (void)share:(NSDictionary *)parameters viewController:(EMWebViewController *)viewController jsbridge:(JSBridge *)bridge {
    if(![parameters isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSInteger socialType = [parameters[@"id"] integerValue];
    
    NSInteger showItem = [parameters[@"showItem"] integerValue];
    NSArray *activies = [[self class] activies:showItem type:socialType];
    
    NSString *title = parameters[@"title"];
    NSString *content = parameters[@"content"];
    NSString *postUrl = parameters[@"url"];
    NSString *callback = parameters[@"callback"];
    NSString *iconUrl = parameters[@"iconUrl"];
    NSString *imageUrl = parameters[@"imageurl"];
    
    if (imageUrl && imageUrl.length) {

        [[[SDWebImageManager sharedManager] imageDownloader] downloadImageWithURL:[NSURL URLWithString: iconUrl] options: SDWebImageDownloaderHighPriority progress: nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished)
         {
             NSArray *contents = [self activityItemTitle:title content:content postUrl:postUrl shareImage:image];
             
             [[EMSocialSDK sharedSDK] shareActivies:activies withItems:contents rootViewController:viewController completionHandler:^(NSString *activityType, BOOL completed, NSDictionary *returnedInfo, NSError *activityError) {
                 [self shareCompletionHandler:activityType status:completed returnedInfo:returnedInfo activityError:activityError callBack:callback viewController:viewController jsbridge:bridge];
             }];
         }];
    } else {
        NSArray *contents = [self activityItemTitle:title content:content postUrl:postUrl shareImage:nil];
        
        [[EMSocialSDK sharedSDK] shareActivies:activies withItems:contents rootViewController:viewController completionHandler:^(NSString *activityType, BOOL completed, NSDictionary *returnedInfo, NSError *activityError) {
            [self shareCompletionHandler:activityType status:completed returnedInfo:returnedInfo activityError:activityError callBack:callback viewController:viewController jsbridge:bridge];
        }];
    }
    //    }s
}

+ (void)shareEntity:(EMShareEntity *)shareEntity viewController:(EMWebViewController *)viewController jsbridge:(JSBridge *)bridge {
    
}

+ (NSArray *)activityItemTitle:(NSString *)title
                       content:(NSString *)content
                       postUrl:(NSString *)postUrl
                    shareImage:(UIImage *)shareImage {
    
    UIImage *icon = [UIImage imageNamed:@"AppIcon60x60"];
    NSMutableArray *items = [NSMutableArray array];
    if (title) {
        [items addObject:title];
    }
    if (content) {
        [items addObject:content];
    }
    //
    if (shareImage) {
        [items addObject:shareImage];
    }
    
    NSMutableDictionary *appendInfo = [NSMutableDictionary dictionary];
    if (icon) {
        [appendInfo setObject:icon forKey:EMActivityWeChatThumbImageKey];
    }
    if ([appendInfo count]) {
        [items addObject:appendInfo];
    }
    
    postUrl = [postUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *URL = [NSURL URLWithString:postUrl];
    if (URL) {
        [items addObject:URL];
    }
    
    return items;
}

+ (void)shareCompletionHandler:(NSString *)activityType
                        status:(BOOL )completed
                  returnedInfo:(NSDictionary *)returnedInfo
                 activityError:(NSError *)activityError
                      callBack:(NSString *)callback
                viewController:(EMWebViewController *)webViewController
                      jsbridge:(JSBridge *)bridge {
    EMSocialType socialType = 0;
    NSString *message = nil;
    NSInteger statusCode = [returnedInfo[EMActivityGeneralStatusCodeKey] integerValue];
    if (statusCode == EMActivityGeneralStatusCodeSuccess) {
        message = @"分享成功";
    } else if (statusCode == EMActivityGeneralStatusCodeUserCancel) {
        message = @"用户取消分享";
    } else {
        message = [activityError localizedDescription];
    }
    
    if ([activityType isEqualToString:UIActivityTypePostToSinaWeibo]) {
        socialType = EMSocialTypeSinaWeibo;
        if (statusCode == EMActivityGeneralStatusCodeNotInstall) {
            message = @"您还没有安装微博，请先安装";
        }
        
    } else if ([activityType isEqualToString:UIActivityTypePostToWeChatSession]) {
        socialType = EMSocialTypeWeChat;
        if (statusCode == EMActivityGeneralStatusCodeNotInstall) {
            message = @"您还没有安装微信，请先安装";
        }
    } else if ([activityType isEqualToString:UIActivityTypePostToWeChatTimeline]) {
        socialType = EMSocialTypeMoments;
        if (statusCode == EMActivityGeneralStatusCodeNotInstall) {
            message = @"您还没有安装微信，请先安装";
        }
    } else if ([activityType isEqualToString:UIActivityTypePostToQQ]) {
        socialType = EMSocialTypeQQ;
        if (statusCode == EMActivityGeneralStatusCodeNotInstall) {
            message = @"您还没有安装QQ，请先安装";
        }
    }
    if (message.length > 0) {
        [BDKNotifyHUD showNotifHUDWithText:message];
    }
    
    if (callback.length > 0) {
        NSString *script = [NSString stringWithFormat:@"%@(%zd,%zd)", callback, socialType, statusCode];
        if (bridge.javascriptContext) {
            [bridge.javascriptContext evaluateScript:script];
        } else {
            [webViewController.webView x_evaluateJavaScript:script];
        }
    }
}

+ (NSArray *)activies:(NSInteger)showItem type:(NSInteger)type{
    
    NSMutableArray *activies = [NSMutableArray array];
    
    if (type != EMSocialTypeAll) {
        switch (type) {
            case EMSocialTypeQQ:
                [activies addObject:[[EMActivityQQ alloc] init]];
                break;
            case EMShareTypeWechat:
                [activies addObject:[[EMActivityWeChatSession alloc] init]];
                break;
            case EMShareTypeMoments:
                [activies addObject:[[EMActivityWeChatTimeline alloc] init]];
                break;
            case EMShareTypeSina:
                [activies addObject:[[EMActivityQQ alloc] init]];
                break;
            default:
                break;
        }
    } else {
        if (EMShareTypeWechat == (EMShareTypeWechat & showItem)) {
            [activies addObject:[[EMActivityWeChatSession alloc] init]];
        }
        if (EMShareTypeMoments == (EMShareTypeMoments & showItem)) {
            [activies addObject:[[EMActivityWeChatTimeline alloc] init]];
        }
        if (EMShareTypeSina == (EMShareTypeSina & showItem)) {
            [activies addObject:[[EMActivityWeibo alloc] init]];
        }
        if (EMShareTypeQQ == (EMShareTypeQQ & showItem)) {
            [activies addObject:[[EMActivityQQ alloc] init]];
        }
    }
    return activies;
}

@end
