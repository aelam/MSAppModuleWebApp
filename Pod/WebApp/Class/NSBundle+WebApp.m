//
//  NSBundle+WebApp.m
//  Pods
//
//  Created by ryan on 07/12/2016.
//
//

#import "NSBundle+WebApp.h"

@interface EMWebAppDummy : NSObject
@end

@implementation EMWebAppDummy
@end


@implementation NSBundle (WebApp)


+ (instancetype)webAppBundle {
    return [NSBundle bundleForClass:[EMWebAppDummy class]];
}


@end
