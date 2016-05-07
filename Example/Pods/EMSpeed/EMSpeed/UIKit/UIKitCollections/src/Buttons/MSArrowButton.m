//
//  EMSwitchButton.m
//  EMStock
//
//  Created by Samuel on 15/3/19.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MSArrowButton.h"
#import <EMSpeed/MSUIKitCore.h>

@implementation MSArrowButton
@synthesize direct = _direct;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _direct = MSArrowDirectionDown;
        _arrowPos =  MSArrowButtonPositionRight;
        
        self.arrowColor = [UIColor darkGrayColor];
        self.arrowHighlightedColor = RGB(183, 183, 183);
        
        self.arrowShadowColor = [UIColor lightGrayColor];
        self.arrowHighlightedShadowColor = [UIColor blackColor];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _direct = MSArrowDirectionDown;
    _arrowPos =  MSArrowButtonPositionRight;
    
    self.arrowColor = [UIColor darkGrayColor];
    self.arrowHighlightedColor = RGB(183, 183, 183);
    
    self.arrowShadowColor = [UIColor lightGrayColor];
    self.arrowHighlightedShadowColor = [UIColor blackColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat begin_x = [self caculateArrowOriginFrame].x;
    CGFloat begin_y = [self caculateArrowOriginFrame].y;
    begin_x = ceilf(begin_x);
    begin_y = ceilf(begin_y);
    
    if (self.imgArrow) {
        [self.imgArrow drawInRect:CGRectMake(begin_x, begin_y,self.arrowSize.width, self.arrowSize.height)];
    }
    else{
        //绘制一层三角阴影
        if (self.arrowShadowColor || self.arrowHighlightedShadowColor) {
            UIColor *shadowColor = self.arrowShadowColor ? self.arrowShadowColor : self.arrowHighlightedShadowColor;
            UIColor *HighlightedShadowColor = self.arrowHighlightedShadowColor ? self.arrowHighlightedShadowColor : self.arrowShadowColor;
            
            CGDrawFillTrianle(context, _direct, CGRectMake(begin_x, begin_y+1, self.arrowSize.width, self.arrowSize.height), self.highlighted ? HighlightedShadowColor : shadowColor);
        }
        
        CGDrawFillTrianle(context, _direct, CGRectMake(begin_x, begin_y,self.arrowSize.width, self.arrowSize.height),
                          self.highlighted ? self.arrowHighlightedColor : self.arrowColor);
    }
}

//计算箭头的起始点坐标
- (CGPoint)caculateArrowOriginFrame{
    
    CGFloat begin_x = 0;
    CGFloat begin_y = 0;
    
    if (self.arrowSize.width <= 0 || self.arrowSize.height <= 0) {
        self.arrowSize = CGSizeMake(6, 6);
    }
    
    if (self.arrowOrigin.x != 0 || self.arrowOrigin.y != 0) {
        begin_x = self.arrowOrigin.x;
        begin_y = self.arrowOrigin.y;
    }
    else {
        
        CGRect titleFrame = self.titleLabel.frame;
        
        
        if (self.titleLabel.text == nil || [self.titleLabel.text isEqualToString:@""]) {
            _arrowPos = MSArrowButtonPositionCenter;
        }
        
        switch (_arrowPos) {
            case  MSArrowButtonPositionLeft:
                begin_x = CGRectGetMinX(titleFrame) - self.arrowSize.width - 4;
                begin_y = self.bounds.size.height/2 - self.arrowSize.height/2;
                break;
            case  MSArrowButtonPositionRight:
                begin_x = CGRectGetMaxX(titleFrame) + 4;
                begin_y = self.bounds.size.height/2 - self.arrowSize.height/2;
                break;
            case  MSArrowButtonPositionDown:
                begin_x = CGRectGetMidX(self.titleLabel.frame) - 0.5*self.arrowSize.width;
                begin_y = (self.frame.size.height - self.arrowSize.height -3);
                break;
            case MSArrowButtonPositionCenter:
                begin_x = CGRectGetWidth(self.frame)/2 - self.arrowSize.width/2;
                begin_y = self.bounds.size.height/2 - self.arrowSize.height/2;
                break;
        }
    }
    
    return CGPointMake(begin_x, begin_y);

}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    [self setNeedsDisplay];
    [super cancelTrackingWithEvent:event];
}

@end
