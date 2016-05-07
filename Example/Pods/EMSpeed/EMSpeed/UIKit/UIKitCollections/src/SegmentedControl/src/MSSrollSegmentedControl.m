//
//  MSSrollSegmentedControl.m
//  EMStock
//
//  Created by flora on 14-10-11.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSSrollSegmentedControl.h"
#import <EMSpeed/MSUIKitCore.h>
#import "MSSegmentCellFactory.h"

@implementation MSSrollSegmentedControl
{
    BOOL _didNeedsScrollToSelectedView;
}
- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        // Initialization code
        self.backgroundColor = RGB(0xff, 0xff, 0xff);
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = self.backgroundColor;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
        self.selectedIndicatorStyle = MSselectedIndicatorStyleMenuTitle;
        
        _segments = [[NSMutableArray alloc] init];
        self.items = items;
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapScrollView:)];
        recognizer.delegate = self;
        recognizer.numberOfTapsRequired = 1;
        [_scrollView addGestureRecognizer:recognizer];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    _scrollView.backgroundColor = backgroundColor;
}

- (void)updateSelectView
{
    Class selectClass = [self selectedViewClassWithStyle:self.selectedIndicatorStyle];
    if (_selectedView == nil || selectClass != [_selectedView class])
    {
        if (_selectedView) {
            [_selectedView removeFromSuperview];
        }
        
        _selectedView = [[selectClass alloc] init];
        _selectedView.style = self.selectedIndicatorStyle;
        [_scrollView addSubview:_selectedView];
    }
}

- (void)updateItems
{
    NSUInteger count = [_items count];
    
    for (UIView *view in _segments) {
        [view removeFromSuperview];
    }
    
    [_segments removeAllObjects];
    
    
    for (int i = 0; i < count; i++)
    {
        UIView<MSSegmentCell> *cell =  [[self segmentCellFactoryClass] segmentCellForSegmentControl:self atIndex:i withObject:[_items objectAtIndex:i]];
        cell.userInteractionEnabled = NO;
        [_scrollView addSubview:cell];
        [_segments addObject:cell];
        
        if (self.selectedSegmentIndex == i)
        {
            cell.selected = YES;
        }
    }
    
    [_scrollView bringSubviewToFront:_selectedView];
    [self setNeedsLayout];
    _didNeedsScrollToSelectedView = YES;
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    _didNeedsScrollToSelectedView = YES;
    [super setSelectedSegmentIndex:selectedSegmentIndex];
}

/**
 *每一页显示的个数
 */
- (CGFloat)itemsCountOfOnePage
{
    CGFloat countOfOnePage =  [_segments count];
    
    if (countOfOnePage > self.pageMaxCount && self.pageMaxCount > 0)
    {
        countOfOnePage = self.pageMaxCount;
    }
    return countOfOnePage;
}

- (void)layoutSubviews
{
    NSUInteger pageCount =  [self itemsCountOfOnePage];
    
    CGFloat width = self.frame.size.width / pageCount;
    CGFloat begin_x = 0;
    
    for (int i = 0;  i < [_segments count] ; i++)
    {
        UIView<MSSegmentCell> *view = [_segments objectAtIndex:i];
        view.frame = CGRectMake(begin_x, 0, width, self.frame.size.height);
        begin_x += width;
        
        if (i == self.selectedSegmentIndex)
        {
            _selectedView.selectedRect = view.frame;
            //判断当前view是否显示
        }
        if (self.didNeedsSeperateLine && [view respondsToSelector:@selector(seperateLayer)])
        {
            if (i < [_segments count] - 1)
            {
                view.seperateLayer.hidden = NO;
            }
            else
            {
                view.seperateLayer.hidden = YES;
            }
        }
    }
    
    _scrollView.frame = self.bounds;
    _scrollView.contentSize = CGSizeMake(MAX(begin_x, _scrollView.frame.size.width), self.frame.size.height);
    _selectedView.frame = CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height);
    
    if (_didNeedsScrollToSelectedView)
    {
        _didNeedsScrollToSelectedView = NO;
        CGRect visibleRect = CGRectMake(_scrollView.contentOffset.x, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        if (CGRectContainsRect(visibleRect, _selectedView.selectedRect) == NO)
        {//当前选中项没显示，滚动到中间
            [_scrollView scrollRectToVisible:_selectedView.selectedRect animated:NO];
        }
    }
}

- (void)didTapScrollView:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:_scrollView];
    
    NSInteger pageCount =  [self itemsCountOfOnePage];
    CGFloat width = self.frame.size.width / pageCount;
    NSUInteger index = (int)(location.x/width);
    
    if (self.selectedSegmentIndex != index)
    {
        self.selectedSegmentIndex = index;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }    
}

@end

