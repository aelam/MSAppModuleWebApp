//
//  EMRefreshTableFooterView.m
//  UIDemo
//
//  Created by Mac mini 2012 on 15-5-14.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSRefreshTableFooterView.h"

@implementation MSRefreshTableFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _lastUpdatedLabel.frame = CGRectMake(0.0f, 30.0f, self.frame.size.width, 20.0f);
        _statusLabel.frame = CGRectMake(0.0f, 10.0f, self.frame.size.width, 20.0f);
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    _lastUpdatedLabel.frame = CGRectMake(0.0f, 30.0f, self.frame.size.width, 20.0f);
//    _statusLabel.frame = CGRectMake(0.0f, 10.0f, self.frame.size.width, 20.0f);
}

- (void)refreshLastUpdatedDate {
    
    if ([_delegate respondsToSelector:@selector(emRefreshTableFooterDataSourceLastUpdated:)]) {
        
        NSDate *date = [_delegate emRefreshTableFooterDataSourceLastUpdated:self];
        
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehaviorDefault];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [dateFormatter stringFromDate:date]];
        [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"MSRefreshTableView_LastRefresh"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        
        _lastUpdatedLabel.text = nil;
        
    }
    
}

- (void)MSRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_state == MSPullRefreshLoading) {
        CGFloat offset = MAX(scrollView.contentOffset.y- (scrollView.contentSize.height - scrollView.frame.size.height), 0);
        offset = MIN(offset, 60);
        UIEdgeInsets e = scrollView.contentInset;
        e.bottom = offset;
        scrollView.contentInset = e;
        
    } else if (scrollView.isDragging) {
        BOOL _loading = NO;
        
        if ([_delegate respondsToSelector:@selector(emRefreshTableFooterDataSourceIsLoading:)]) {
            _loading = [_delegate emRefreshTableFooterDataSourceIsLoading:self];
        }
        
        if (_state == MSPullRefreshPulling && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height + MSRefreshTableHeaderView_HEIGHT) && !_loading) {
            [self setState:MSPullRefreshNormal];
        } else if (_state == MSPullRefreshNormal && scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + MSRefreshTableHeaderView_HEIGHT) && !_loading) {
            [self setState:MSPullRefreshPulling];
        }
        
        if (scrollView.contentInset.bottom != 0) {
            UIEdgeInsets e = scrollView.contentInset;
            e.bottom = 0;
            scrollView.contentInset = e;
        }
    }
}

- (void)MSRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
    
    BOOL _loading = NO;
    if ([_delegate respondsToSelector:@selector(emRefreshTableFooterDataSourceIsLoading:)]) {
        _loading = [_delegate emRefreshTableFooterDataSourceIsLoading:self];
    }
    
    if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + MSRefreshTableHeaderView_HEIGHT) && !_loading) {
        
        if ([_delegate respondsToSelector:@selector(emRefreshTableFooterDidTriggerRefresh:)]) {
            [_delegate emRefreshTableFooterDidTriggerRefresh:self];
        }
        
        [self setState:MSPullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationBeginsFromCurrentState:YES];
        UIEdgeInsets e = scrollView.contentInset;
        e.bottom = 60.f;
        scrollView.contentInset = e;
        [UIView commitAnimations];
    }
}

- (void)MSRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    CGFloat height = MAX(scrollView.contentSize.height, scrollView.frame.size.height);
    self.frame = CGRectMake(0.0f, height, self.frame.size.width, MSRefreshTableHeaderView_HEIGHT);
//    [self performSelector:@selector(finishedLoading:) withObject:scrollView afterDelay:.5f];
    
    [UIView animateWithDuration:.2f animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        UIEdgeInsets e = scrollView.contentInset;
        e.bottom = 0;
        [scrollView setContentInset:e];
    } completion:^(BOOL finished) {
        [self setState:MSPullRefreshNormal];
    }];
}


- (void)finishedLoading:(UIScrollView *)scrollView {

}




@end