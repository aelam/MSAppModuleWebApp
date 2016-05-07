//
//  EMRefreshTableHeaderView.h
//  EMStock
//
//  Created by xoHome on 14-11-3.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f

#define MSRefreshTableHeaderView_HEIGHT 65

typedef enum{
    MSPullRefreshPulling = 0,
    MSPullRefreshNormal,
    MSPullRefreshLoading,
} MSPullRefreshState;

typedef enum
{
    MSRefreshViewStyleWhite,
    MSRefreshViewStyleGray
}MSRefreshViewStyle;

@class MSRefreshTableHeaderView;

@protocol MSRefreshTableHeaderViewDelegate
- (void)MSRefreshTableHeaderDidTriggerRefresh:(MSRefreshTableHeaderView*)view;
- (BOOL)MSRefreshTableHeaderDataSourceIsLoading:(MSRefreshTableHeaderView*)view;
@optional
- (NSDate*)MSRefreshTableHeaderDataSourceLastUpdated:(MSRefreshTableHeaderView*)view;
@end

NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.")
@interface MSRefreshTableHeaderView : UIView {
    
    id __unsafe_unretained _delegate;
    MSPullRefreshState _state;
    
    UILabel *_lastUpdatedLabel;
    UILabel *_statusLabel;
    UIImageView *_arrowImage;
    UIActivityIndicatorView *_activityView;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) UILabel *lastUpdatedLabel;
@property (nonatomic, strong) UILabel *statusLabel;


- (id)initWithFrame:(CGRect)frame;

- (void)refreshLastUpdatedDate;
- (void)MSRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)MSRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)MSRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

- (void)setArrowImage:(UIImage *)image;

@end

NS_EXTENSION_UNAVAILABLE_IOS("Use view controller based solutions where appropriate instead.")
@interface MSAnimatedImagesRefreshTableHeaderView : MSRefreshTableHeaderView {
    
    UIImageView *_animtedImageView;
}

- (id)initWithFrame:(CGRect)frame
             images:(NSArray *)images;

@end






