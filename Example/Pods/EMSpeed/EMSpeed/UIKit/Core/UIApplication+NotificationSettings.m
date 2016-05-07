//
//  UIApplication+NotificationSettings.m
//  EMSpeed
//
//  Created by ryan on 15/12/18.
//
//

#import "UIApplication+NotificationSettings.h"

@implementation UIApplication (NotificationSettings)

- (NSUInteger)EMNotificationSettingTypes
{
    NSUInteger types;
    if ([self respondsToSelector:@selector(currentUserNotificationSettings)]) {
        types = [self currentUserNotificationSettings].types;
    }
    else {
        types = [self enabledRemoteNotificationTypes];
    }
    return types;
}

@end
