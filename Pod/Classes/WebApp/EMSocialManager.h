//
//  EMSocialManager.h
//  Pods
//
//  Created by Allen on 10/04/2017.
//
//

#import <Foundation/Foundation.h>
#import <MSAppModuleWebApp/JSBridge.h>
#import "EMShareEntity+Parameters.h"

@class EMWebViewController;

@interface EMSocialManager : NSObject

+ (void)share:(NSDictionary *)parameters viewController:(EMWebViewController *)viewController jsbridge:(JSBridge *)bridge;

@end
