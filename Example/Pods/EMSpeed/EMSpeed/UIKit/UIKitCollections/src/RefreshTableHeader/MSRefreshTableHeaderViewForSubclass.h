//
//  MSRefreshTableHeaderViewForSubclass.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-14.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSRefreshTableHeaderView.h"

@interface MSRefreshTableHeaderView (Private)
- (void)setState:(MSPullRefreshState)aState;
@end