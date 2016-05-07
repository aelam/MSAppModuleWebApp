//
//  NSString+EMStringDrawing.m
//  EMStock
//
//  Created by flora on 14-9-11.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "NSString+Drawing.h"

@implementation NSString (Drawing)

- (void)ms_drawAtPoint:(CGPoint)point withFont:(UIFont *)font {
    [self drawAtPoint:point withAttributes:@{NSFontAttributeName: font}];
}

- (void)ms_drawAtPoint:(CGPoint)point withFont:(UIFont *)font withColor:(UIColor*)color{
    [self drawAtPoint:point withAttributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName:color}];
}

- (CGSize)ms_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:NULL].size;
}

- (void)ms_drawAtPoint:(CGPoint)point
          boundingRect:(CGRect)boundingRect
              withFont:(UIFont *)font
                 color:(UIColor *)color
              aligment:(int)aligment
{
    [self ms_drawAtPoint:point boundingRect:boundingRect withFont:font color:color aligment:aligment lineHeight:0];
}

- (void)ms_drawAtPoint:(CGPoint)point
          boundingRect:(CGRect)boundingRect
              withFont:(UIFont *)font
                 color:(UIColor *)color
              aligment:(int)aligment
            lineHeight:(CGFloat)lineHeight
{
    CGRect rect =  Point2Rect(boundingRect,point, aligment, font);
    aligment = aligment&3;//排除自定义的排序类型
    [self ms_drawInRect:rect withFont:font color:color aligment:aligment lineHeight:lineHeight];
}

- (void)ms_drawInRect:(CGRect)rect
             withFont:(UIFont *)font
                color:(UIColor *)color
             aligment:(int)aligment
{
    [self ms_drawInRect:rect withFont:font color:color aligment:aligment lineHeight:0];
}


- (void)ms_drawInRect:(CGRect)rect
             withFont:(UIFont *)font
                color:(UIColor *)color
             aligment:(int)aligment
           lineHeight:(CGFloat)lineHeight
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = aligment;
    if (lineHeight > 0)
    {
        paragraph.lineSpacing = lineHeight;
    }
    
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:
                               color,NSForegroundColorAttributeName,
                               font,NSFontAttributeName,
                               paragraph,NSParagraphStyleAttributeName,nil];
    [self drawInRect:rect withAttributes:attribute];
}

- (void)ms_drawInRect:(CGRect)rect
       withAttributes:(NSDictionary *)attribute
{
    [self drawInRect:rect withAttributes:attribute];
}

/**
 *默认行高、默认靠左绘制
 */
- (void)ms_drawInRect:(CGRect)rect
             withFont:(UIFont *)font
                color:(UIColor *)color
{
    NSDictionary *attribute = [NSDictionary dictionaryWithObjectsAndKeys:
                               color,NSForegroundColorAttributeName,
                               font,NSFontAttributeName,nil];
    [self drawInRect:rect withAttributes:attribute];
}


- (CGSize)ms_sizeWithFont:(UIFont *)font
{
    NSDictionary *attributes = @{NSFontAttributeName: font};
    return [self sizeWithAttributes:attributes];
}

CGRect _Point2Rect(CGRect boundingRect, CGPoint point, int nAnchor,UIFont *font) {
    return boundingRect;
}


@end


