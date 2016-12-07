//
//  MSCustomMenuItem.h
//  Pods
//
//  Created by ryan on 5/16/16.
//
//

#import "MSMenuItemData.h"

@interface MSCustomMenuItem : MSMenuItemData

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *tintColor;
@property (nonatomic, strong) NSString *action;

+ (NSArray <MSMenuItemData *> *)itemsWithData:(NSArray *)data;

@end
