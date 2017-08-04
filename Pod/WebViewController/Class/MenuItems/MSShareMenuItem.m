//
//  MSShareMenuItem.m
//  Pods
//
//  Created by ryan on 5/16/16.
//
//

#import "MSShareMenuItem.h"

@implementation MSShareMenuItem


+ (NSString *)key {
    return @"Share";
}

+ (instancetype)itemWithData:(NSDictionary *)itemData {
    MSShareMenuItem *item = [[self alloc] init];
    item.shareInfo = itemData;
    
    return item;
}

@end
