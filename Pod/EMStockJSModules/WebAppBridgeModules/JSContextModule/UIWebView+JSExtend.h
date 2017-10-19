//
//  UIWebView+JSExtend.h
//  EMStock
//
//  Created by ryan on 15/8/27.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JSContext;

@interface UIWebView (JSExtend)

- (void)attachExtendActionsWithContext:(JSContext *)context;

@end
