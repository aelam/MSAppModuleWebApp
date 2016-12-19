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

    UIImage *image = nil;
    if ([[UIImage class] respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        NSBundle *highPriorityBundle = [NSBundle overrideWebAppImageResouceBundle];
        NSBundle *lowPriorityBundle = [NSBundle webAppImageResouceBundle];
        if (highPriorityBundle) {
            image = [UIImage imageNamed:name inBundle:highPriorityBundle compatibleWithTraitCollection:nil];
            if (!image) {
                image = [UIImage imageNamed:name inBundle:lowPriorityBundle compatibleWithTraitCollection:nil];
            }
        } else {
            image = [UIImage imageNamed:name inBundle:lowPriorityBundle compatibleWithTraitCollection:nil];
        }
        return image;
    } else {
        image = [UIImage imageNamed:name];
    }
    return image;
}


@end

