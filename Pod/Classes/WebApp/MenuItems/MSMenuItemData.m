//
//  MSMenuItemData.m
//  Pods
//
//  Created by ryan on 5/16/16.
//
//

#import "MSMenuItemData.h"

static NSMutableArray<Class> *MenuItemDataClasses;

void MSMenuItemDataClasses(Class);
void MSMenuItemDataClasses(Class moduleClass)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MenuItemDataClasses = [NSMutableArray new];
    });
    
    // Register module
    [MenuItemDataClasses addObject:moduleClass];
}


@implementation MSMenuItemData


+ (NSString *)key {
    return nil;
}

+ (NSArray <MSMenuItemData> *)itemsWithData:(NSArray *)data {
    NSMutableDictionary *items = [NSMutableDictionary dictionary];
    for(NSDictionary *i in data) {
        
    }
    
    return items;
}

@end
