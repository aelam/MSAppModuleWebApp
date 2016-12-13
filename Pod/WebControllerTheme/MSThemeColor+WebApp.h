//
//  UIColor+WebApp.h
//  Pods
//
//  Created by ryan on 06/12/2016.
//
//

#import <UIKit/UIKit.h>
#import <MSThemeKit/MSThemeKit.h>

@protocol MSThemeColorWebApp

@optional
+ (UIColor *)web_statusBarColor;
+ (UIColor *)web_bgColor;
+ (UIColor *)web_navbarItemTextColor;

@end

@interface MSThemeColor (WebApp)<MSThemeColorWebApp>

@end
