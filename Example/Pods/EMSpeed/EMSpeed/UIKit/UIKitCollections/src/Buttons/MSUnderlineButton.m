//
//  MSUnderlineButton.m
//  EMSpeed
//
//  Created by ryan on 16/2/14.
//
//

#import "MSUnderlineButton.h"
#import <EMSpeed/MSContext.h>

@implementation MSUnderlineButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    return self;
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

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Measure the font size, so the line fits the text.
    // Could be that "titleLabel" is something else in other classes like UILable, dont know.
    // So make sure you fix it here if you are enhancing UILabel or something else..
    CGSize fontSize = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    //	CGSize fontSize =[self.currentTitle sizeWithFont:self.titleLabel.font
    //											forWidth:self.bounds.size.width
    //									   lineBreakMode:NSLineBreakByTruncatingTail];
    
    // Calculate the starting point (left) and target (right)
    float fontLeft = self.bounds.size.width/2 - fontSize.width/2.0;
    float fontRight = self.bounds.size.width/2 + fontSize.width/2.0;
    
    UIColor *titleColor = nil;
    if (self.selected)
    {
        titleColor = [self titleColorForState:UIControlStateSelected];
    }
    else if (self.highlighted)
    {
        titleColor = [self titleColorForState:UIControlStateHighlighted];
    }
    else
    {
        titleColor = [self titleColorForState:UIControlStateNormal];
    }
    
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft)
    {
        CGDrawLine(ctx, 0, self.bounds.size.height - 1, fontSize.width, self.bounds.size.height - 1,titleColor);
    }
    else
    {
        CGDrawLine(ctx, fontLeft, self.bounds.size.height - 1, fontRight, self.bounds.size.height - 1, titleColor);
    }
    
    [super drawRect:rect];
}


@end
