//
//  MSShareMenuItem.h
//  Pods
//
//  Created by ryan on 5/16/16.
//
//

#import "MSMenuItemData.h"


@interface MSShareMenuItem : MSMenuItemData

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *action;
@property (nonatomic, strong) NSDictionary *shareInfo;

@end
