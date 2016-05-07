//
//  UnderlineUIButton.m
//  EMSpeed
//
//  Created by flora deng on 1/10/12.
//  Copyright (c) 2012 Emoney.cn. All rights reserved.
//

#import "MSLinkedButton.h"
#import "MSContext.h"

@implementation MSLinkedButton


- (void)setUrl:(NSString *)aUrl
{
    if (aUrl && ![aUrl isEqualToString:_url]) {
        _url = [aUrl copy];
        [self removeTarget:self action:@selector(openURL) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(openURL) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)openURL
{
    if (_url && [_url length] > 0) {
#if TARGET_APP_EXTENSION
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_url]];
#endif
    }
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    if (state == UIControlStateNormal)
    {
        [self setNeedsDisplay];
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if ([self titleColorForState:UIControlStateHighlighted])
    {
        [self setNeedsDisplay];
    }
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if ([self titleColorForState:UIControlStateSelected])
    {
        [self setNeedsDisplay];
    }
}

-(void)drawRect:(CGRect)rect
{
	// Get the Render Context
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	// Measure the font size, so the line fits the text.
	// Could be that "titleLabel" is something else in other classes like UILable, dont know.
	// So make sure you fix it here if you are enhancing UILabel or something else..
    
    NSDictionary *attributes = @{NSFontAttributeName: self.titleLabel.font};
    CGRect fontRect = [self.currentTitle boundingRectWithSize:self.bounds.size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
	
	// Calculate the starting point (left) and target (right)
	float fontLeft = self.bounds.size.width/2 - fontRect.size.width/2.0;
	float fontRight = self.bounds.size.width/2 + fontRect.size.width/2.0;
    
    UIColor *titleColor = nil;
    if (self.selected)
    {
        titleColor = [self titleColorForState:UIControlStateSelected];
        UIColor *c2 = [self titleColorForState:UIControlStateNormal];
        /**
         *  如果颜色值一致, 则处理一下alpha值
         */
        if ([self isSameColor1:titleColor color2:c2]) {
            CGFloat r1, g1, b1, a1;
            BOOL successful = [titleColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
            if (successful) {
                titleColor = [self convertHighlightedColor:titleColor];
            }
        }
    }
    else if (self.highlighted)
    {
        titleColor = [self titleColorForState:UIControlStateHighlighted];
        UIColor *c2 = [self titleColorForState:UIControlStateNormal];
        /**
         *  如果颜色值一致, 则处理一下alpha值
         */
        if ([self isSameColor1:titleColor color2:c2]) {
            CGFloat r1, g1, b1, a1;
            BOOL successful = [titleColor getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
            if (successful) {
                titleColor = [self convertHighlightedColor:titleColor];
            }
        }
    }
    else
    {
        titleColor = [self titleColorForState:UIControlStateNormal];
    }
    
    CGFloat h1 = ceilf(fontRect.size.height/2);
    CGFloat y1 = ceilf(CGRectGetHeight(self.frame)/2.f + h1) + _offsetY;
    
	if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft)
    {
        CGDrawLine(ctx, 0, y1, fontRect.size.width, y1,titleColor);
    }
    else
    {
        CGDrawLine(ctx, fontLeft, y1, fontRight, y1, titleColor);
    }
	
	// should be nothing, but who knows...
	[super drawRect:rect];
}

- (BOOL)isSameColor1:(UIColor *)color1 color2:(UIColor *)color2
{
    CGFloat r1, g1, b1, a1;
    CGFloat r2, g2, b2, a2;
    
    BOOL succ1 = [color1 getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    BOOL succ2 = [color1 getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    
    if (succ1 && succ2 && (r1 == r2 && g1 == g2 && b1 == b2 && a1 == a2)) {
        return YES;
    }
    
    return NO;
}

- (UIColor *)convertHighlightedColor:(UIColor *)color
{
    CGFloat r1, g1, b1, a1;
    BOOL succ1 = [color getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    
    if (succ1) {
        a1 = 0.2f;
        return [UIColor colorWithRed:r1 green:g1 blue:b1 alpha:a1];
    }
    
    return color;
}

@end
