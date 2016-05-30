//
//  MSCustomMenuItem.m
//  Pods
//
//  Created by ryan on 5/16/16.
//
//

#import "MSCustomMenuItem.h"

@implementation MSCustomMenuItem

+ (NSString *)key {
    return @"CustomItem";
}

+ (NSArray <MSMenuItemData *> *)itemsWithData:(NSArray *)data {
    NSMutableArray <MSMenuItemData *>*items = [NSMutableArray array];
    for(NSDictionary *i in data) {
        MSMenuItemData *item = [self itemWithData:i];
        [items addObject:item];
    }
    
    return items;
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
