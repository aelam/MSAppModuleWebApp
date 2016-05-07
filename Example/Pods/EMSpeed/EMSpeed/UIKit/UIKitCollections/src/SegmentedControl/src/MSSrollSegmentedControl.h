//
//  MSSrollSegmentedControl.h
//  EMStock
//
//  Created by flora on 14-10-11.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSSegmentedControl.h"


@interface MSSrollSegmentedControl : MSSegmentedControl<UIGestureRecognizerDelegate>
{
    UIScrollView *_scrollView;
}

@property (nonatomic, assign) NSUInteger pageMaxCount;//默认为0，每页显示的最大个数

@end
