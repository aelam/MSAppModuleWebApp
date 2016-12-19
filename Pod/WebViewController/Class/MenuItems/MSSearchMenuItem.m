//
//  MSSearchMenuItem.m
//  Pods
//
//  Created by ryan on 5/16/16.
//
//

#import "MSSearchMenuItem.h"

@implementation MSSearchMenuItem

//+ (void)load {
//    MSMenuItemDataClasses(self);
//}

+ (NSString *)key {
    return @"Search";
}

+ (instancetype)itemWithData:(NSDictionary *)itemData {
    return [[self alloc] init];
}


@end
