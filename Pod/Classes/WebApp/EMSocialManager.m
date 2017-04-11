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

+ (void)share:(NSDictionary *)parameters viewController:(UIViewController *)viewController jsbridge:(JSBridge *)bridge {
    if(![parameters isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSInteger socialType = [parameters[@"id"] integerValue];
    
    if (socialType != EMSocialTypeAll) {
        if ([viewController respondsToSelector:@selector(share:)]) {
            EMShareEntity *shareEntity = [EMShareEntity shareEntityWithParameters:parameters];
                [viewController share:shareEntity];
        }
    } else {
        
        NSInteger showItem = [parameters[@"showItem"] integerValue];
        NSArray *activies = [[self class] activies:showItem];
        
        UIImage *appIcon = [UIImage imageNamed:@"AppIcon60x60"];
        NSString *title = parameters[@"title"];
        NSString *content = parameters[@"content"];
        NSString *postUrl = parameters[@"url"];
        NSString *callback = parameters[@"callback"];
        NSString *iconUrl = parameters[@"iconUrl"];
        NSString *imageUrl = parameters[@"imageurl"];
        
        if (imageUrl && imageUrl.length) {
            [[SDWebImageManager sharedManager] downloadImageWithURL: [NSURL URLWithString: iconUrl] options: SDWebImageHighPriority progress: nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL)
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
    }
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

+ (NSArray *)activies:(NSInteger)showItem {
    NSMutableArray *activies = [NSMutableArray array];
    
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
    
    return activies;
}

+ (void)shareCompletionHandler:(NSString *)activityType
                        status:(BOOL )completed
                  returnedInfo:(NSDictionary *)returnedInfo
                 activityError:(NSError *)activityError
                      callBack:(NSString *)callback
                viewController:(EMWebViewController *)webViewController
                      jsbridge:(JSBridge *)bridge {
    EMSocialType socialType = 0;
    NSInteger statusCode = 0;
    
    NSString *message = nil;
    if ([activityType isEqualToString:UIActivityTypePostToSinaWeibo]) {
        message = returnedInfo[EMActivityWeiboStatusMessageKey];
        socialType = EMSocialTypeSinaWeibo;
        NSNumber *errorCode = returnedInfo[EMActivityWeiboStatusCodeKey];
        if (errorCode) {
            if ([errorCode integerValue] == EMActivityWeiboStatusCodeSuccess) {
                statusCode = 0;
                [BDKNotifyHUD showNotifHUDWithText:@"分享成功"];
            } else if ([errorCode integerValue] == EMActivityWeiboStatusCodeUserCancel) {
                statusCode = -1;
            }
        }
    } else if ([activityType isEqualToString:UIActivityTypePostToWeChatSession]) {
        message = returnedInfo[EMActivityWeChatStatusMessageKey];
        socialType = EMSocialTypeWeChat;
        NSNumber *errorCode = returnedInfo[EMActivityWeChatStatusCodeKey];
        
        if (activityError) {
            statusCode = EMActivityWeChatStatusCodeAppNotInstall;
            
            [BDKNotifyHUD showNotifHUDWithText:@"您还没有安装微信，请先安装"];
        }else if (errorCode) {
            if ([errorCode integerValue] == EMActivityWeChatStatusCodeSuccess) {
                statusCode = 0;
                [BDKNotifyHUD showNotifHUDWithText:returnedInfo[EMActivityWeChatStatusMessageKey]];
            } else if ([errorCode integerValue] == EMActivityWeChatStatusCodeUserCancel) {
                statusCode = -1;
            }
        }else if (!returnedInfo) {
            statusCode = EMActivityWeChatStatusCodeAppNotInstall;
            [BDKNotifyHUD showNotifHUDWithText:@"您还没有安装微信，请先安装"];
        }
        
    } else if ([activityType isEqualToString:UIActivityTypePostToWeChatTimeline]) {
        message = returnedInfo[EMActivityWeChatStatusMessageKey];
        socialType = EMSocialTypeMoments;
        NSNumber *errorCode = returnedInfo[EMActivityWeChatStatusCodeKey];
        
        if(activityError){
            statusCode = EMActivityWeChatStatusCodeAppNotInstall;
            [BDKNotifyHUD showNotifHUDWithText:@"您还没有安装微信，请先安装"];
        } else  if (errorCode) {
            if ([errorCode integerValue] == EMActivityWeChatStatusCodeSuccess) {
                statusCode = 0;
                [BDKNotifyHUD showNotifHUDWithText:returnedInfo[EMActivityWeChatStatusMessageKey]];
            } else if ([errorCode integerValue] == EMActivityWeChatStatusCodeUserCancel) {
                statusCode = -1;
            }
        }else if (!returnedInfo) {
            statusCode = EMActivityWeChatStatusCodeAppNotInstall;
            [BDKNotifyHUD showNotifHUDWithText:@"您还没有安装微信，请先安装"];
        }
    } else if ([activityType isEqualToString:UIActivityTypePostToQQ]) {
        message = returnedInfo[EMActivityQQStatusMessageKey];
        socialType = EMSocialTypeQQ;
        NSNumber *errorCode = returnedInfo[EMActivityQQStatusCodeKey];
        
        if(activityError){
            statusCode = -1;
            [BDKNotifyHUD showNotifHUDWithText:@"您还没有安装QQ，请先安装"];
        }else if (errorCode) {
            if ([errorCode integerValue] == EMActivityQQStatusCodeSuccess) {
                statusCode = 0;
                [BDKNotifyHUD showNotifHUDWithText:@"分享成功"];
            } else if ([errorCode integerValue] == EMActivityQQStatusCodeUserCancel) {
                statusCode = -1;
            }
        }else if (!returnedInfo) {
            statusCode = EMActivityWeChatStatusCodeAppNotInstall;
            [BDKNotifyHUD showNotifHUDWithText:@"您还没有安装QQ，请先安装"];
        }
    }
    
    
    if (callback.length > 0) {
        NSString *script = [NSString stringWithFormat:@"%@(%zd,%zd)", callback, socialType, statusCode];
        // FIXME: 在callback指明却不实现的情况直接使用webview会卡死
        if (bridge.javascriptContext) {
            [bridge.javascriptContext evaluateScript:script];
        } else {
            [webViewController.webView x_evaluateJavaScript:script];
        }
        
    } else {
        if (message.length > 0) {
            [BDKNotifyHUD showNotifHUDWithText:message];
        }
    }
}

@end
