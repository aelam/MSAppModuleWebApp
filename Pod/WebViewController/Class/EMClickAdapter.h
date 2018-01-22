//
//  EMClickAdapter.h
//  Pods
//
//  Created by ryan on 06/12/2016.
//
//

#import <Foundation/Foundation.h>

@protocol EMClickAdapter <NSObject>

+ (void)event:(NSString *)event;
+ (void)event:(NSString *)event attributes:(NSDictionary *)attributes;

+ (id)beginLogPageView:(NSString *)pageId;
+ (void)endLogPageView:(NSString *)pageId attributes:(NSDictionary *)attributes;

+ (void)showNoWifiAlerView;

@end
