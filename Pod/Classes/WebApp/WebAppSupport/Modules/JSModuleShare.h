//
//  JSModuleShare.h
//  Pods
//
//  Created by ryan on 4/26/16.
//
//

#import <Foundation/Foundation.h>
#import "JSBridgeModule.h"

@protocol JSModuleShare <JSBridgeModule>

@end

@interface JSModuleShare : NSObject <JSModuleShare>

+ (NSString *)shareConfig;


@end
