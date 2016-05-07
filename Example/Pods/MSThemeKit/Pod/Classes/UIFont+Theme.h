//
//  UIFont+Theme.h
//  Pods
//
//  Created by ryan on 2/29/16.
//
//

#import <UIKit/UIKit.h>

@interface UIFont (Theme)

+ (UIFont *)fontForKey:(NSString *)key;

/**
 *按比例适配大屏手机
 *特定得页面需求
 */
+ (UIFont *)adaptiveFontForKey:(NSString *)key;
+ (UIFont *)adaptiveFontForFont:(UIFont *)font;


@end
