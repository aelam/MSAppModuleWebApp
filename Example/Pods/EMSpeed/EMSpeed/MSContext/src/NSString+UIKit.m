//
//  NSString+MSDraw.m
//  Pods
//
//  Created by ryan on 15/10/23.
//
//

#import "NSString+UIKit.h"

@implementation NSString (MSSize)

- (CGSize)ms_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *stringAttributes = [NSDictionary dictionaryWithObjects:@[font, paragraphStyle] forKeys:@[NSFontAttributeName, NSParagraphStyleAttributeName]];
    CGRect newRect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:stringAttributes context:nil];
    CGSize sizeAlignedToPixel = CGSizeMake(ceilf(newRect.size.width), ceilf(newRect.size.height));
    
    // 经过调研, sizeWithFont 与 label的text 高度计算值有1个像素的差异, 因此在这边高度+1了, 否则label会显示不全
    return CGSizeMake(sizeAlignedToPixel.width, sizeAlignedToPixel.height + 1);
}

- (CGFloat)ms_heightWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize
{
    CGSize size = [self ms_sizeWithFont:font constrainedToSize:maxSize];
    return size.height;
}

- (CGFloat)ms_widthWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize
{
    CGSize size = [self ms_sizeWithFont:font constrainedToSize:maxSize];
    return size.width;
}


@end

@implementation NSString (MSDraw)

@end
