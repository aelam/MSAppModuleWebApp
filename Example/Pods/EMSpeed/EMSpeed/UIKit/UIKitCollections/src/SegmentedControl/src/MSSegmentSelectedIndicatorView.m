//
//  EMSegmentSelectedView.m
//  EMStock
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MSSegmentSelectedIndicatorView.h"
#import <EMSpeed/MSUIKitCore.h>

@implementation MSSegmentSelectedIndicatorView
@synthesize selectedRect = _selectedRect;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.indicatorBackgroundColor = RGB(0xf8,0xf8, 0xf8);
        self.indicatorColor = RGB(0x46, 0x90, 0xef);
        self.borderColor = RGB(0xe5, 0xe5, 0xe5);
    }
    return self;
}

- (void)setSelectedRect:(CGRect)selectedRect
{
    if (CGRectEqualToRect(_selectedRect, selectedRect) == NO)
    {
        _selectedRect = selectedRect;
        [self setNeedsDisplay];
    }
    
}

- (void)drawRect:(CGRect)rect
{
    // do nothing subclass implement
    
}

@end


@implementation MSSegmentSelectedIndicatorArrowBar




- (void)drawRect:(CGRect)rect
{
    if (CGRectEqualToRect(self.selectedRect, CGRectZero) == NO)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGRect drawRect = self.selectedRect;
        CGFloat hoffset   = 0;
        CGFloat voffset   = 1;
        CGFloat minWidth = self.fixedWidth + 10;
        
        if (self.fixedWidth > 0 && minWidth < drawRect.size.width)
        {
            hoffset = .5 * (drawRect.size.width - minWidth);
        }
        
        drawRect.origin.x += hoffset;
        drawRect.size.width -= 2 * hoffset;
        
        CGContextMoveToPoint(context, 0, rect.size.height);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
        [self.borderColor setStroke];
        CGContextDrawPath(context, kCGPathStroke);
        
        CGFloat lineHeight = 1;
        CGFloat endY = rect.size.height - voffset;
        CGFloat minX = CGRectGetMinX(drawRect),midX = CGRectGetMidX(drawRect),maxX = CGRectGetMaxX(drawRect);
        
        CGContextMoveToPoint(context, minX, endY);
        CGContextAddLineToPoint(context, minX, endY - lineHeight);
        CGContextAddLineToPoint(context, midX-3, endY - lineHeight);
        CGContextAddLineToPoint(context, midX, endY - 3 - lineHeight);
        CGContextAddLineToPoint(context, midX+3, endY-lineHeight);
        CGContextAddLineToPoint(context, maxX, endY-lineHeight);
        CGContextAddLineToPoint(context, maxX, endY);
        CGContextAddLineToPoint(context, minX, endY);
        CGContextClosePath(context);
        [[self indicatorColor] set];
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

@end


@implementation MSSegmentSelectedIndicatorArrowLine

- (void)drawRect:(CGRect)rect
{
    if (CGRectEqualToRect(self.selectedRect, CGRectZero) == NO)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, NULL, 0, rect.size.height);
        
        CGRect frame = self.selectedRect;
        //        frame.origin.x = 400;
        
        NSLog(@"frame = %@", NSStringFromCGRect(frame));
        
        CGPathAddLineToPoint(path, NULL, CGRectGetMidX(frame)-4, rect.size.height);
        CGPathAddLineToPoint(path, NULL, CGRectGetMidX(frame), rect.size.height - 5);
        CGPathAddLineToPoint(path, NULL, CGRectGetMidX(frame)+4, rect.size.height);
        CGPathAddLineToPoint(path, NULL, rect.size.width, rect.size.height);
        
        [self.indicatorColor setStroke];
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathStroke);
        
        CGPathCloseSubpath(path);
        CGContextAddPath(context, path);
        [self.indicatorBackgroundColor setFill];
        CGContextDrawPath(context, kCGPathFill);
        CFRelease(path);
    }
}

@end

