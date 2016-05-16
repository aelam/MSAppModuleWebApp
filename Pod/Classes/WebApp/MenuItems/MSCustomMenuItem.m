//
//  MSCustomMenuItem.m
//  Pods
//
//  Created by ryan on 5/16/16.
//
//

#import "MSCustomMenuItem.h"

@implementation MSCustomMenuItem

+ (void)load {
    MSMenuItemDataClasses(self);
}

+ (NSString *)key {
    return @"CustomItem";
}

@end
