//
//  MSShareMenuItem.m
//  Pods
//
//  Created by ryan on 5/16/16.
//
//

#import "MSShareMenuItem.h"
#import "EMShareEntity+Parameters.h"

@implementation MSShareMenuItem

//+ (void)load {
//    MSMenuItemDataClasses(self);
//}

+ (NSString *)key {
    return @"Share";
}

+ (instancetype)itemWithData:(NSDictionary *)itemData {
    MSShareMenuItem *item = [[self alloc] init];
    
    item.shareEntity = [EMShareEntity shareEntityWithParameters:itemData];
    
    return item;
}

@end
