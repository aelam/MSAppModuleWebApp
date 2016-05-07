//
//  EMRefreshTableHeaderView.m
//  EMStock
//
//  Created by xoHome on 14-11-3.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSRefreshTableHeaderView.h"
#import "MSContext.h"
#import "MSUIKitCore.h"


@interface MSRefreshTableHeaderView (Private)
- (void)setState:(MSPullRefreshState)aState;
@end

@implementation MSRefreshTableHeaderView
@synthesize lastUpdatedLabel = _lastUpdatedLabel;
@synthesize statusLabel = _statusLabel;
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = RGB(0xff, 0xff, 0xff);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = [UIColor redColor];
        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _lastUpdatedLabel=label;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 50.0f, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont boldSystemFontOfSize:13.0f];
        label.textColor = [UIColor redColor];
        label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _statusLabel=label;
        
    }
    
    return self;
}

#pragma mark - 懒加载
- (UIImageView *)arrowImage
{
    if (!_arrowImage) {
        UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MSUIResName(@"refreshHeader_arrow")]];
        [self addSubview:_arrowImage = arrowImage];
    }
    return _arrowImage;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) {
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityView.bounds = self.arrowImage.bounds;
        [self addSubview:_activityView = activityView];
    }
    return _activityView;
}


#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
    
    if ([_delegate respondsToSelector:@selector(MSRefreshTableHeaderDataSourceLastUpdated:)]) {
        
        NSDate *date = [_delegate MSRefreshTableHeaderDataSourceLastUpdated:self];
        
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:date]];
        [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EMRefreshTableView_LastRefresh"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        
        _lastUpdatedLabel.text = nil;
        
    }
    
}

- (void)setState:(MSPullRefreshState)aState
{
    switch (aState) {
        case MSPullRefreshNormal:
        {
            _statusLabel.text = NSLocalizedString(@"Release to refresh...", @"Release to refresh status");
            if (_state == MSPullRefreshLoading) {
                self.arrowImage.transform = CGAffineTransformIdentity;
                
                [UIView animateWithDuration:FLIP_ANIMATION_DURATION animations:^{
                    self.activityView.alpha = 0.0;
                } completion:^(BOOL finished) {
                    self.arrowImage.alpha = 1.0;
                    self.activityView.alpha = 1.0;
                    [self.activityView stopAnimating];
                }];
            } else {
                [UIView animateWithDuration:FLIP_ANIMATION_DURATION animations:^{
                    self.arrowImage.transform = CGAffineTransformIdentity;
                }];
            }
        }
            break;
        case MSPullRefreshPulling:
        {
            _statusLabel.text = NSLocalizedString(@"Pull down to refresh...", @"Pull down to refresh status");
            [UIView animateWithDuration:FLIP_ANIMATION_DURATION animations:^{
                self.arrowImage.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            }];
            [self refreshLastUpdatedDate];
        }
            break;
        case MSPullRefreshLoading:
        {
            [self.activityView startAnimating];
            self.arrowImage.alpha = 0.0;
            _statusLabel.text = NSLocalizedString(@"Loading...", @"Loading Status");
        }
            break;
    }
    
    _state = aState;
    
//    NSLog(@"state = %d", _state);
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)MSRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_state == MSPullRefreshLoading) {
        
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        UIEdgeInsets e = scrollView.contentInset;
        e.top = offset;
        scrollView.contentInset = e;
        
    } else if (scrollView.isDragging) {
        BOOL _loading = NO;
        
        if ([_delegate respondsToSelector:@selector(MSRefreshTableHeaderDataSourceIsLoading:)]) {
            _loading = [_delegate MSRefreshTableHeaderDataSourceIsLoading:self];
        }
        
        if (_state == MSPullRefreshPulling && scrollView.contentOffset.y > -MSRefreshTableHeaderView_HEIGHT && scrollView.contentOffset.y < 0.0f && !_loading) {
            [self setState:MSPullRefreshNormal];
        } else if (_state == MSPullRefreshNormal && scrollView.contentOffset.y < -MSRefreshTableHeaderView_HEIGHT && !_loading) {
            [self setState:MSPullRefreshPulling];
        }
        
        if (scrollView.contentInset.top != 0) {
            UIEdgeInsets e = scrollView.contentInset;
            e.top = 0;
            scrollView.contentInset = e;
        }
        
    }
    
}

- (void)MSRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
    BOOL _loading = NO;
    if ([_delegate respondsToSelector:@selector(MSRefreshTableHeaderDataSourceIsLoading:)]) {
        _loading = [_delegate MSRefreshTableHeaderDataSourceIsLoading:self];
    }
    
    if (scrollView.contentOffset.y <= - MSRefreshTableHeaderView_HEIGHT && !_loading) {
        
        if ([_delegate respondsToSelector:@selector(MSRefreshTableHeaderDidTriggerRefresh:)]) {
            [_delegate MSRefreshTableHeaderDidTriggerRefresh:self];
        }
        
        [self setState:MSPullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationBeginsFromCurrentState:YES];
        UIEdgeInsets e = scrollView.contentInset;
        e.top = 60.f;
        scrollView.contentInset = e;
        [UIView commitAnimations];
    }
}

- (void)MSRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    [self performSelector:@selector(finishedLoading:) withObject:scrollView afterDelay:.25f];
    
}

- (void)finishedLoading:(UIScrollView *)scrollView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    UIEdgeInsets e = scrollView.contentInset;
    e.top = 0;
    [scrollView setContentInset:e];
    [UIView commitAnimations];
    
    [self setState:MSPullRefreshNormal];
}

- (void)setArrowImage:(UIImage *)image
{
    self.arrowImage.image = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 箭头
    self.arrowImage.center = CGPointMake(50, self.frame.size.height - self.arrowImage.frame.size.height + 10);
    
    // 指示器
    self.activityView.center = self.arrowImage.center;
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    
    _delegate=nil;
    _statusLabel = nil;
    _lastUpdatedLabel = nil;
}


@end



@implementation MSAnimatedImagesRefreshTableHeaderView


- (id)initWithFrame:(CGRect)frame
             images:(NSArray *)images
{
    assert(images && [images count]>0);
    
    self = [super initWithFrame:frame];
    if(self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = RGB(0xff, 0xff, 0xff);

        _animtedImageView = [[UIImageView alloc] init];
        _animtedImageView.contentMode = UIViewContentModeCenter;
        _animtedImageView.frame = CGRectMake(MSAdjustedWH(80.0f), frame.size.height - 45, 48.0f, 30);
        [_animtedImageView setAnimationImages:images];
        _animtedImageView.animationDuration = .5f;
        [self addSubview:_animtedImageView];
        _animtedImageView.image = [images firstObject];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_animtedImageView.frame) + 10, frame.size.height - 40.0f, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont boldSystemFontOfSize:13.0f];
        label.textColor = [UIColor grayColor];
//        label.shadowColor = shadowColor;//[UIColor colorWithWhite:0.9f alpha:1.0f];
        label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        _statusLabel=label;
        
        [self setState:MSPullRefreshNormal];
    }
    
    return self;
    
}

- (void)setState:(MSPullRefreshState)aState{
    [NSObject cancelPreviousPerformRequestsWithTarget:_animtedImageView selector:@selector(stopAnimating) object:nil];
    switch (aState) {
        case MSPullRefreshPulling:
            [_animtedImageView startAnimating];
            break;
        case MSPullRefreshNormal:
            [_animtedImageView performSelector:@selector(stopAnimating) withObject:nil afterDelay:FLIP_ANIMATION_DURATION];
            break;
        case MSPullRefreshLoading:
            break;
        default:
            break;
    }
    
    [super setState:aState];
}

- (void)MSRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    [super MSRefreshScrollViewDidScroll:scrollView];
    
    if (_state != MSPullRefreshLoading && scrollView.isDragging) {
        if ([_animtedImageView isAnimating] == NO)
        {
            [_animtedImageView startAnimating];
        }
    }
}

@end



