//
//  UIImage+WebAppBundle.h
//  Pods
//
//  Created by ryan on 07/12/2016.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (WebAppBundle)

+ (UIImage *)webAppImageNamed:(NSString *)name;

@end


@interface UIImage (WebAppResourceBundle)

+ (UIImage *)webAppResourceImageNamed:(NSString *)name;

@end
