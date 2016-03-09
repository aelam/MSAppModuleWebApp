//
//  MSWebAppInfo.h
//  Pods
//
//  Created by ryan on 3/9/16.
//
//

#import <Foundation/Foundation.h>
#import "MSAppSettingsWebApp.h"

@interface MSWebAppInfo : NSObject

+ (NSDictionary *)getWebAppInfoWithSettings:(id<MSAppSettingsWebApp>)appSettings;

@end
