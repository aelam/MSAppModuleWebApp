//
//  UIViewController+searchStock.h
//  EMStock
//
//  Created by flora on 14-9-28.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewControllerSearchSupport <NSObject>

@property (nonatomic, readonly) BOOL isSearchItemEnabled;
- (UIBarButtonItem *)searchItem;

- (void)doSearch;

@end

@interface UIViewController (searchStock) <UIViewControllerSearchSupport>

- (UIBarButtonItem *)searchItem;
- (void)doSearch;

@end
