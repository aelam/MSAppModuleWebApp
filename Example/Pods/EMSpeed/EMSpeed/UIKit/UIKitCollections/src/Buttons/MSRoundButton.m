//
//  MSRoundButton.m
//  UI
//
//  Created by Samuel on 15/4/2.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSRoundButton.h"
#import "UIColor+CIELAB.h"

const static CGFloat kRoundButtonCornerRadius = 4.f;
const static CGFloat kRoundButtonBorderWidth = 1.f;


@implementation MSRoundButton
@synthesize corners = _corners;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _corners = UIRectCornerAllCorners;
        _cornerRadius = kRoundButtonCornerRadius;
        _borderWidth = kRoundButtonBorderWidth;
        
        [self setAdjustsImageWhenHighlighted:NO];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setCorners:_corners cornerRadius:_cornerRadius];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _corners = UIRectCornerAllCorners;
    _cornerRadius = kRoundButtonCornerRadius;
    _borderWidth = kRoundButtonBorderWidth;
    
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setCorners:_corners cornerRadius:_cornerRadius];
}

- (void)setCorners:(UIRectCorner)corners
{
    _corners = corners;
    [self setCorners:_corners cornerRadius:_cornerRadius];
}

- (void)setCornerRadius:(float)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self setCorners:_corners cornerRadius:_cornerRadius];
}

- (void)setCorners:(UIRectCorner)corners cornerRadius:(float)cornerRadius
{
    if (corners) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                       byRoundingCorners:corners
                                                             cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame         = self.bounds;
        maskLayer.path          = maskPath.CGPath;
        self.layer.mask         = maskLayer;
    }
}


+ (MSRoundButton *)roundButtonWithFrame:(CGRect)frame
                                corners:(UIRectCorner)corners
                           cornerRadius:(float)cornerRadius
                       normalStateColor:(UIColor *)normalStateColor
                    highLightStateColor:(UIColor *)highLightStateColor
{
    MSRoundButton *btn1 = [MSRoundButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = frame;
    [btn1 setCorners:corners];
    btn1.cornerRadius = cornerRadius;
    btn1.borderWidth = kRoundButtonBorderWidth;
    btn1.backgroundColor = normalStateColor;
    btn1.normalStateColor = normalStateColor;
    btn1.highLightStateColor = highLightStateColor;
    [btn1 setBackgroundImage:[btn1 buttonImageFromColor:highLightStateColor] forState:UIControlStateHighlighted];
    
    return btn1;
}


+ (MSRoundButton *)roundButtonWithFrame:(CGRect)frame
                                  color:(UIColor *)color
{
    MSRoundButton *btn = [MSRoundButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setCorners:UIRectCornerAllCorners];
    btn.cornerRadius = kRoundButtonCornerRadius;
    btn.borderWidth = kRoundButtonBorderWidth;
    
    UIColor *normalStateColor = color;
    UIColor *highLightStateColor = [color offsetWithLightness:-20.f a:0 b:0 alpha:0];
    btn.backgroundColor = normalStateColor;
    btn.normalStateColor = normalStateColor;
    btn.highLightStateColor = highLightStateColor;
    [btn setBackgroundImage:[btn buttonImageFromColor:highLightStateColor] forState:UIControlStateHighlighted];
    
    return btn;
}



- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}


- (void)setNeedsDisplay
{
    if (self.highLightStateColor) {
        [self setCorners:self.corners];
        [self setBackgroundImage:[self buttonImageFromColor:self.highLightStateColor] forState:UIControlStateHighlighted];
    }
    [super setNeedsDisplay];
}

- (void)defaultSetting
{
    if (_corners == 0) {
        self.layer.borderWidth = _borderWidth;
        self.layer.cornerRadius = _cornerRadius;
        self.layer.masksToBounds = YES;
    }
    else {
        [self setCorners:_corners cornerRadius:_cornerRadius];
    }
}

-(void)roundButtonWithWhiteStyle {
    _corners = 0;
    [self defaultSetting];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)roundButtonWithGreenStyle {
    [self defaultSetting];
    self.backgroundColor = [UIColor colorWithRed:92/255.0 green:184/255.0 blue:92/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:76/255.0 green:174/255.0 blue:76/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:69/255.0 green:164/255.0 blue:84/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)roundButtonWithBlueStyle {
    [self defaultSetting];
    self.backgroundColor = [UIColor colorWithRed:66/255.0 green:139/255.0 blue:202/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:53/255.0 green:126/255.0 blue:189/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:51/255.0 green:119/255.0 blue:172/255.0 alpha:1]] forState:UIControlStateHighlighted];
}


-(void)roundButtonWithSkyBlueStyle {
    [self defaultSetting];
    self.backgroundColor = [UIColor colorWithRed:91/255.0 green:192/255.0 blue:222/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:70/255.0 green:184/255.0 blue:218/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:57/255.0 green:180/255.0 blue:211/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)roundButtonWithYellowStyle{
    [self defaultSetting];
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:173/255.0 blue:78/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:238/255.0 green:162/255.0 blue:54/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:237/255.0 green:155/255.0 blue:67/255.0 alpha:1]] forState:UIControlStateHighlighted];
}

-(void)roundButtonWithRedStyle{
    [self defaultSetting];
    self.backgroundColor = [UIColor colorWithRed:217/255.0 green:83/255.0 blue:79/255.0 alpha:1];
    self.layer.borderColor = [[UIColor colorWithRed:212/255.0 green:63/255.0 blue:58/255.0 alpha:1] CGColor];
    [self setBackgroundImage:[self buttonImageFromColor:[UIColor colorWithRed:210/255.0 green:48/255.0 blue:51/255.0 alpha:1]] forState:UIControlStateHighlighted];
}


- (UIImage *)buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
