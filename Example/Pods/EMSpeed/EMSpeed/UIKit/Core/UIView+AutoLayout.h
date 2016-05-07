//
//  UIView+autoLayout.h
//  EMStock
//
//  Created by xoHome on 14-10-6.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)


/**
 *  添加约束, 根据contentInsets, 水平和竖直方向约束
 *
 *  @param contentInsets 上下左右间距
 *  @param subView       约束的对象view
 */
- (void)ms_addConstraintsWithContentInsets:(UIEdgeInsets)contentInsets
                                   subView:(UIView *)subView;

@end
