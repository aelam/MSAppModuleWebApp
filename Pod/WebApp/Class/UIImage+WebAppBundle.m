//
//  UIImage+WebAppBundle.m
//  Pods
//
//  Created by ryan on 07/12/2016.
//
//

#import "UIImage+WebAppBundle.h"
#import "NSBundle+WebApp.h"

@implementation UIImage (WebAppBundle)

+ (UIImage *)webAppImageNamed:(NSString *)name {
    if ([[UIImage class] respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        return [UIImage imageNamed:name inBundle:[NSBundle webAppBundle] compatibleWithTraitCollection:nil];
    } else {
        return [UIImage imageNamed:name];
    }
}

+ (UIImage *)webAppResourceImageNamed:(NSString *)name {
    if ([[UIImage class] respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        return [UIImage imageNamed:name inBundle:[NSBundle webAppResourceBundle] compatibleWithTraitCollection:nil];
    } else {
        return [UIImage imageNamed:name];
    }
}


@end

