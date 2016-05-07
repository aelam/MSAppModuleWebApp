//
//  MSBorderView.m
//  EMStock
//
//  Created by xoHome on 14-9-30.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSBorderView.h"
#import <EMSpeed/MSUIKitCore.h>

#define kDefaultBorderColor RGB(0xe5, 0xe5, 0xe5)

void _CGFillRect(CGContextRef context,CGRect rt,UIColor *color)
{
    CGContextSetAllowsAntialiasing(context,NO);
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextAddRect(context,rt);
    CGContextDrawPath(context,kCGPathFill);
}

@implementation MSBorderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.borderColor = kDefaultBorderColor;
        self.border = MSBorderStyleAll;
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.borderColor = kDefaultBorderColor;
    self.border = MSBorderStyleAll;
}

- (void)setBorder:(MSBorderStyle)border {
    _border = border;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    _CGFillRect(ctx, rect, self.backgroundColor);
    
    if (self.border == MSBorderStyleNone) {
        return;
    }
    
    rect = UIEdgeInsetsInsetRect(rect, self.contentInsets);
    
    // Drawing code
    if (self.border & MSBorderStyleLeft)
    {
        CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    }
    
    if (self.border & MSBorderStyleRight)
    {
        CGContextMoveToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    }
    
    if (self.border & MSBorderStyleTop)
    {
        CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    }
    
    if (self.border & MSBorderStyleBottom)
    {
        CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    }
    
    CGContextSetStrokeColorWithColor(ctx, self.borderColor.CGColor);
    CGContextDrawPath(ctx, kCGPathStroke);
}


@end

