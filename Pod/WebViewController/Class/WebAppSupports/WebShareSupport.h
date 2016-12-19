//
//  WebShareSupport.h
//  EMStock
//
//  Created by jenkins on 15/6/11.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EMShareEntity;

@protocol WebShareSupport <NSObject>

@property (nonatomic, readonly) EMShareEntity *shareEntity;
@property (nonatomic, readonly) BOOL isShareItemEnabled;

- (void)share:(EMShareEntity *)shareEntity;

@optional
- (void)doShare;
- (UIBarButtonItem *)shareItem;

@end

