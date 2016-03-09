//
//  UIViewController+EMShare.h
//  EMStock
//
//  Created by jenkins on 15/6/11.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMShareEntity.h"

@class EMShareEntity;

@protocol UIViewControllerShareSupport <NSObject>

@property (nonatomic, readonly) EMShareEntity *shareEntity;
@property (nonatomic, readonly) BOOL isShareItemEnabled;

- (void)share:(EMShareEntity *)shareEntity;

@optional
- (void)doShare;
- (UIBarButtonItem *)shareItem;

@end

@interface UIViewController (EMShare) <UIViewControllerShareSupport>

@property (nonatomic, readonly) EMShareEntity *shareEntity;
@property (nonatomic, readwrite) BOOL isShareItemEnabled;
- (void)share:(EMShareEntity *)shareEntity;

@end
