//
//  MSMenuItemData.h
//  Pods
//
//  Created by ryan on 5/16/16.
//
//

#import <Foundation/Foundation.h>

//extern void MSMenuItemDataClasses(Class);


@protocol MSMenuItemData <NSObject>

+ (NSString *)key;
+ (instancetype)itemWithData:(NSDictionary *)itemData;

@end


@interface MSMenuItemData : NSObject <MSMenuItemData>

+ (NSArray <MSMenuItemData *> *)itemsWithData:(NSArray *)data;


@end