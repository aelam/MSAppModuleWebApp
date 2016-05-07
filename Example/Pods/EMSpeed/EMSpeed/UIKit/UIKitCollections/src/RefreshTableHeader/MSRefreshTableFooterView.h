//
//  EMRefreshTableFooterView.h
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-14.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSRefreshTableHeaderView.h"
#import "MSRefreshTableHeaderViewForSubclass.h"


@class MSRefreshTableFooterView;
@protocol MSRefreshTableFooterViewDelegate
- (void)emRefreshTableFooterDidTriggerRefresh:(MSRefreshTableFooterView*)view;
- (BOOL)emRefreshTableFooterDataSourceIsLoading:(MSRefreshTableFooterView*)view;
@optional
- (NSDate*)emRefreshTableFooterDataSourceLastUpdated:(MSRefreshTableFooterView*)view;
@end

NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.")
@interface MSRefreshTableFooterView : MSRefreshTableHeaderView {
    
}

@end