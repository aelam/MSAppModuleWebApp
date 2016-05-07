//
//  UIView+RoundCorner.h
//  EMSpeed
//
//  Created by Lyy on 15/9/11.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RoundCorner)

/**
 *  设置圆角
 *
 *  @param corners 圆角位置
 */
- (void)setMaskViewRoundingCorners:(UIRectCorner)corners;
- (void)setMaskViewRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)radius;
- (void)setMaskViewRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

@end
