////
////  WebShareSupport.h
////  EMStock
////
////  Created by jenkins on 15/6/11.
////  Copyright (c) 2015年 flora. All rights reserved.
////
//
#import <UIKit/UIKit.h>

@protocol WebShareSupport <NSObject>

@property (nonatomic, readonly) NSDictionary *shareInfo;
@property (nonatomic, readonly) BOOL isShareItemEnabled;

@optional
- (UIBarButtonItem *)shareItem;

@end


@protocol WebShareSupportImp <NSObject>

- (void)share:(NSDictionary *)shareInfo;

@end

