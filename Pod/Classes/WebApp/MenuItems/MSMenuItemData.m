//
//  MSMenuItemData.m
//  Pods
//
//  Created by ryan on 5/16/16.
//
//

#import "MSMenuItemData.h"

static NSMutableDictionary<NSString *, Class> *MenuItemDataClasses;

void MSMenuItemDataClasses(Class);
void MSMenuItemDataClasses(Class moduleClass)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MenuItemDataClasses = [NSMutableDictionary new];
    });
    
    // Register module
    [MenuItemDataClasses setObject:moduleClass forKey:[moduleClass key]];
}


@implementation MSMenuItemData


+ (NSString *)key {
    return nil;
}

+ (NSArray <MSMenuItemData *> *)itemsWithData:(NSArray *)data {
    NSMutableArray <MSMenuItemData *>*items = [NSMutableArray array];
    for(NSDictionary *i in data) {
        Class menuItemClass = MenuItemDataClasses[i[@"key"]];
        MSMenuItemData *item = [menuItemClass itemWithData:i];
        [items addObject:item];
    }
    
    return items;
}

@end
