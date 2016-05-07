//
//  UIImage+UIImage_FontAwesome.m
//  FontAwesome-iOS Demo
//
//  Created by Pedro Piñera Buendía on 22/08/13.
//  Copyright (c) 2013 Alex Usbergo. All rights reserved.
//

#import "UIImage+FontAwesome.h"
#import "NSString+FontAwesome.h"

@implementation UIImage (UIImage_FontAwesome)
/**
 *	This method generates an UIImage with a given FontAwesomeIcon and format parameters
 *
 *	@param	identifier	NSString that identifies the icon
 *	@param	bgColor	UIColor for background image Color
 *	@param	iconColor	UIColor for icon color
 *	@param	scale	Scale factor between the image size and the icon size
 *	@param	size	Size of the image to be generated
 *
 *	@return	Image to be used wherever you want
 */
+(UIImage*)imageWithIcon:(NSString*)identifier backgroundColor:(UIColor*)bgColor iconColor:(UIColor*)iconColor iconScale:(CGFloat)scale andSize:(CGSize)size{
    
    
    //// Text Drawing
    //// Abstracted Attributes
    NSString* textContent = [NSString fontAwesomeIconStringForIconIdentifier:identifier];
    
    float fontSize=(MIN(size.height,size.width))*scale;
    UIFont *textFont = [UIFont fontWithName:@"FontAwesome" size:(float)((int)fontSize)];
    CGSize textSize = [textContent sizeWithAttributes:@{NSFontAttributeName: textFont}];
    size = CGSizeMake(MAX(textSize.width, size.width), MAX(textSize.height, size.height));
    
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, size.width, size.height)];
    [bgColor setFill];
    [rectanglePath fill];
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(0, .5 * (size.height-fontSize), size.width, fontSize);
    [iconColor setFill];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [textContent drawInRect: textRect withFont:textFont lineBreakMode: NSLineBreakByClipping alignment: NSTextAlignmentCenter];
#pragma clang diagnostic pop
    
    //Image returns
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
