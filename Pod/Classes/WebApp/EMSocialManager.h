//
//  EMSocialManager.h
//  Pods
//
//  Created by Allen on 10/04/2017.
//
//

#import <Foundation/Foundation.h>
#import <MSAppModuleWebApp/JSBridge.h>

@interface EMSocialManager : NSObject

+ (void)share:(NSDictionary *)parameters viewController:(UIViewController *)viewController jsbridge:(JSBridge *)bridge;

@end
