//
//  EMThemeDownloadButton.m
//  EMStock
//
//  Created by zhangzhiyao on 15-2-2.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MSProgressDownloadButton.h"
#import <EMSpeed/MSUIKitCore.h>
#import <EMSpeed/MSContext.h>

@interface MSProgressDownloadButton () {
    float _progress;
    CAShapeLayer *_border;
}

@end

@implementation MSProgressDownloadButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _border = [CAShapeLayer layer];
        _border.lineWidth = 1;
        _border.strokeColor = RGB(22, 111, 217).CGColor;
        _border.fillColor = nil;
        [self.layer addSublayer:_border];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _border.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5].CGPath;
    _border.frame = self.bounds;
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFillRect(context, CGRectMake(0, 0, rect.size.width*_progress, rect.size.height), RGB(22, 111, 217));
}

@end
