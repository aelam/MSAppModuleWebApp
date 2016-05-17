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

+ (instancetype)itemWithData:(NSDictionary *)itemData {
    MSCustomMenuItem *item = [[self alloc] init];
    item.title = itemData[@"title"];
    item.icon = itemData[@"icon"];
    item.tintColor = itemData[@"tintColor"];
    item.action = itemData[@"callback"];
    
    return item;
}


@end
