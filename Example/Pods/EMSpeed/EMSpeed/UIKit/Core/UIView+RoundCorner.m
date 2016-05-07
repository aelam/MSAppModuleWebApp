//
//  UIView+RoundCorner.h
//  EMSpeed
//
//  Created by Lyy on 15/9/11.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "UIView+RoundCorner.h"

@implementation UIView (RectCorner)

- (void)setMaskViewRoundingCorners:(UIRectCorner)corners {
    [self setMaskViewRoundingCorners:corners cornerRadius:10.f];
}

- (void)setMaskViewRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)radius {
    [self setMaskViewRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
}

- (void)setMaskViewRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:corners
                                           cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


@end
