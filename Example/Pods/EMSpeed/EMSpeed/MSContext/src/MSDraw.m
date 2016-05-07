//
//  EMContext.m
//  EMStock
//
//  Created by flora on 14-9-11.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSDraw.h"
#import <UIKit/UIKit.h>

CGRect TextDrawableRect(CGRect boundingRect, CGPoint point, int nAnchor,UIFont *font);

/**
 *  创建一个圆角矩形
 *
 *  @param topLeft     上左
 *  @param topRight    上右
 *  @param bottomLeft  下左
 *  @param bottomRight 下右
 *
 *  @return 创建一个圆角矩形
 */
//UIRectRadius UIRectRadiusMake(CGFloat topLeft, CGFloat topRight, CGFloat bottomLeft, CGFloat bottomRight) {
//    UIRectRadius radius = {topLeft, topRight, bottomLeft, bottomRight};
//    return radius;
//}


/**
 判断四个弧度是否相同
 */
BOOL UIRectRadiusEqualToRectRadius(UIRectRadius radius1, UIRectRadius radius2) {
    return radius1.topLeft == radius2.topLeft &&
    radius1.topRight == radius2.topRight &&
    radius1.bottomLeft == radius2.bottomLeft &&
    radius1.bottomRight == radius2.bottomRight;
}



CGSize sizeWithFont(NSString* string, UIFont* font)
{
    if ([string respondsToSelector:@selector(sizeWithAttributes:)]) {
        NSDictionary *attributes = @{NSFontAttributeName: font};
        return [string sizeWithAttributes:attributes];
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [string sizeWithFont:font];
#pragma clang diagnostic pop
    }
}


CGSize CGDrawAtPointExt(NSString *string, CGPoint point, UIFont *font)
{
    CGSize size = CGSizeZero;
    if ([string respondsToSelector:@selector(drawInRect:withAttributes:)]) {
        NSDictionary *attributes = @{NSFontAttributeName: font};
        size = [string sizeWithAttributes:attributes];
        [string drawAtPoint:point withAttributes:attributes];
    }
    else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [string drawAtPoint:point withFont:font];
#pragma clang diagnostic pop
    }
    return size;
}


void CGDrawRect(CGContextRef context,CGRect rt,UIColor *color)
{
    CGContextSetAllowsAntialiasing(context,NO);
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextSetFillColorWithColor(context,[UIColor clearColor].CGColor);
    CGContextAddRect(context,rt);
    CGContextDrawPath(context,kCGPathFillStroke);
}


void CGFillRect(CGContextRef context,CGRect rt,UIColor *color)
{
    CGContextSetAllowsAntialiasing(context,NO);
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextAddRect(context,rt);
    CGContextDrawPath(context,kCGPathFill);
}


void CGFillStrokeRect(CGContextRef context,CGRect rt,UIColor *color)
{
    CGContextSetAllowsAntialiasing(context,NO);
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextAddRect(context,rt);
    CGContextDrawPath(context,kCGPathFillStroke);
}


void CGDrawFillTrianle(CGContextRef context, MSArrowDirection cDirect, CGRect rect, UIColor *color)
{
    CGContextSaveGState(context);
    
    switch (cDirect) {
        case MSArrowDirectionDown:
            CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x + rect.size.width,rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x + .5 *rect.size.width,rect.origin.y + rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
            break;
        case MSArrowDirectionRight:
            CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x + rect.size.width,rect.origin.y + .5 *rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x,rect.origin.y + rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
            break;
        case MSArrowDirectionUp:
            CGContextMoveToPoint(context, rect.origin.x + .5 *rect.size.width, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x + rect.size.width,rect.origin.y + rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x ,rect.origin.y + rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x + .5 *rect.size.width, rect.origin.y);
            break;
        case MSArrowDirectionLeft:
            CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + .5 *rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x + rect.size.width,rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x + rect.size.width ,rect.origin.y + rect.size.height);
            CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + .5 *rect.size.height);
            break;
        default:
            break;
    }
    //CGContextClip(context);
    [color setFill];
    CGContextDrawPath(context, kCGPathFill);
    CGContextRestoreGState(context);
}


void CGDrawFillDiamond(CGContextRef context, int nX, int nY, int width, int height, UIColor *color)
{
    CGDrawFillTrianle(context, MSArrowDirectionUp, CGRectMake(ceilf(nX-width/2), nY, width, height), color);
    CGDrawFillTrianle(context, MSArrowDirectionDown, CGRectMake(ceilf(nX-width/2), nY+height, width, height), color);
}


void CGDrawLad(CGContextRef context,int nX, int nY,int w, int h,UIColor* color)
{
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGPoint pts[] = {CGPointMake(nX+5,nY), CGPointMake( nX+w-5,nY),
        CGPointMake(nX+w, nY+h),CGPointMake(nX, nY+h),CGPointMake(nX+5,nY)};
    CGContextAddLines(context,pts,5);
    CGContextDrawPath(context,kCGPathStroke);
}


void CGFillLad(CGContextRef context,int nX, int nY,int w, int h,UIColor* color)
{
    CGContextSetFillColorWithColor(context,color.CGColor);
    
    CGPoint pts[] = {CGPointMake(nX+5,nY), CGPointMake( nX+w-5,nY),
        CGPointMake(nX+w, nY+h),CGPointMake(nX, nY+h),CGPointMake(nX+5,nY)};
    CGContextAddLines(context,pts,5);
    CGContextDrawPath(context,kCGPathFillStroke);
}


void CGDarwGradientRect(CGRect rect,CGFloat compnents[8])
{
    // emulate the tint colored bar
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat locations[2] = { 0.0, 1.0 };
    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
    
    CGGradientRef topGradient = CGGradientCreateWithColorComponents(myColorspace, compnents, locations, 2);
    CGContextDrawLinearGradient(context, topGradient, CGPointMake(0, rect.origin.y), CGPointMake(0,rect.size.height), 0);
    CGGradientRelease(topGradient);
    
    CGColorSpaceRelease(myColorspace);
}


CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint) {
    CGFloat distance;
    //Square difference in x
    CGFloat xDifferenceSquared = pow(firstPoint.x - secondPoint.x, 2);
    // NSLog(@"xDifferenceSquared: %f", xDifferenceSquared);
    
    // Square difference in y
    CGFloat yDifferenceSquared = pow(firstPoint.y - secondPoint.y, 2);
    // NSLog(@"yDifferenceSquared: %f", yDifferenceSquared);
    
    // Add and take Square root
    distance = sqrt(xDifferenceSquared + yDifferenceSquared);
    // NSLog(@"Distance: %f", distance);
    return distance;
}



void CGDrawString(CGRect boundingRect, NSString* str ,CGPoint point, int nAnchor, UIColor *color, UIFont *font)
{
    CGRect drawableRect = TextDrawableRect(boundingRect, point, nAnchor, font);
    CGDrawStringInRect(str,drawableRect,nAnchor,color,font);
}

void CGDrawStringInRect(NSString* str ,CGRect rt, int nAnchor, UIColor *color, UIFont *font)
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context,YES);
    //CGContextSetTextDrawingMode(context,kCGTextStroke);
    [color set];
    nAnchor&=3;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [str drawInRect:rt withFont:font lineBreakMode:NSLineBreakByTruncatingTail alignment:nAnchor];
#pragma clang diagnostic pop
}


CGPoint getTextCenterPoint(NSString *str,UIFont *font,CGPoint origin,int nAnchor)
{
    CGSize textSize = sizeWithFont(str, font);
    if (nAnchor & NSTextAlignmentCenter)
    {
        origin.x = floorf(origin.x - .5 * textSize.width);
    }
    if (nAnchor&NSTextAlignmentRight)
    {
        origin.x = floorf(origin.x - textSize.width);
    }
    if (nAnchor & MSTextVerticalAlignmentCenter)
    {
        origin.y = floorf(origin.y - .5 * textSize.height);
    }
    
    
    return origin;
}


CGSize CGDrawTextWithShadow( NSString *text,
                          UIColor  *textColor,
                          UIColor *shadowColor,
                          UIFont   *font,
                          CGPoint point,
                          int nAnchor,
                          CGSize  shadowOffset)
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    point = getTextCenterPoint(text, font, point, nAnchor);
    CGContextSaveGState(context);
    if (NO == CGSizeEqualToSize(shadowOffset, CGSizeZero))
    {
        CGContextSetShadowWithColor(context, shadowOffset, 1.0f, shadowColor.CGColor);
    }
    
    [textColor set];
    //  CGContextSetStrokeColorWithColor(context, textColor.CGColor);
    
    CGSize size = CGDrawAtPointExt(text, point, font);
    CGContextRestoreGState(context);
    return size;
}


void CGDrawRectExt(CGContextRef context,int x1,int y1,int x2,int y2,UIColor *color)
{
    CGContextSetAllowsAntialiasing(context,NO);
    CGRect rect = CGRectMake(x1, y1, x2-x1, y2-y1);
    CGDrawRect(context, rect, color);
}


void CGFillRectExt(CGContextRef context,int x1,int y1,int x2,int y2,UIColor *color)
{
    CGContextSetAllowsAntialiasing(context,NO);
    CGRect rect = CGRectMake(x1, y1, x2-x1, y2-y1);
    CGFillRect(context, rect, color);
}


void CGFillStrokeRectExt(CGContextRef context,int x1,int y1,int x2,int y2,UIColor *color)
{
    CGContextSetAllowsAntialiasing(context,NO);
    CGRect rect = CGRectMake(x1, y1, x2-x1, y2-y1);
    CGFillStrokeRect(context, rect, color);
}


void CGFillArc(CGContextRef context,CGFloat x,CGFloat y, CGFloat radius,
               CGFloat startAngle,CGFloat endAngle,int clockwise,UIColor *color)
{
    CGContextSetAllowsAntialiasing(context,YES);
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextMoveToPoint(context, x, y);
    CGContextAddArc(context, x,y, radius, startAngle,endAngle, clockwise);
    CGContextDrawPath(context,kCGPathFillStroke);
}


void CGDrawArc(CGContextRef context,CGFloat x,CGFloat y, CGFloat radius,
               CGFloat startAngle,CGFloat endAngle,int clockwise,UIColor *color)
{
    CGContextSetAllowsAntialiasing(context,NO);
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextSetFillColorWithColor(context,[UIColor clearColor].CGColor);
    CGContextMoveToPoint(context, x, y);
    CGContextAddArc(context, x,y, radius, startAngle,endAngle, clockwise);
    CGContextDrawPath(context,kCGPathFillStroke);
}


void CGDrawLine( CGContextRef context,int x1,int y1,int x2,int y2,UIColor* color)
{
    CGContextSetAllowsAntialiasing(context,NO);
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextMoveToPoint(context, x1,y1);
    CGContextAddLineToPoint(context, x2,y2);
    CGContextStrokePath(context);
}


void CGDrawLineSmooth( CGContextRef context,int x1,int y1,int x2,int y2,UIColor* color)
{
    CGContextSetAllowsAntialiasing(context,YES);
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextMoveToPoint(context, x1,y1);
    CGContextAddLineToPoint(context, x2,y2);
    CGContextStrokePath(context);
}


void CGDrawDotLineDash(CGContextRef context,int x1,int y1,int x2,int y2,UIColor *color,CGFloat *dash,int count)
{
    CGContextSetAllowsAntialiasing(context,NO);
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextSetLineDash(context, 0.0, dash, count);
    CGContextMoveToPoint(context, x1,y1);
    CGContextAddLineToPoint(context, x2,y2);
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, nil, 0);
}


void CGDrawDotLine( CGContextRef context,int x1,int y1,int x2,int y2,UIColor *color)
{
    CGContextSetAllowsAntialiasing(context,NO);
    CGFloat dash[] = {3.0, 3.0};
    CGContextSetStrokeColorWithColor(context,color.CGColor);
    CGContextSetLineDash(context, 0.0, dash, 1);
    CGContextMoveToPoint(context, x1,y1);
    CGContextAddLineToPoint(context, x2,y2);
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, nil, 0);
}


void CGDrawRoundRectWithParam(CGContextRef c,CGRect roundRect,UIRectCorner corners,CGSize cornerRadii,UIColor* bgcolor,UIColor *borderColor,UIColor *shadow)
{
    
    if (nil == borderColor)
    {
        borderColor = [UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:0.6];
    }
    
    if (shadow)
    {
        roundRect = UIEdgeInsetsInsetRect(roundRect, UIEdgeInsetsMake(0, 0, 4, 0));
    }
    
    UIBezierPath *thePath = [UIBezierPath bezierPathWithRoundedRect:roundRect
                                                  byRoundingCorners:corners
                                                        cornerRadii:cornerRadii];
    CGPathRef path = thePath.CGPath;
    
    CGContextAddPath(c, path);
    [bgcolor setFill];
    CGContextSetLineWidth(c, 0.5);
    [borderColor setStroke];
    
    if (shadow)
    {
        CGContextSetShadowWithColor(c, CGSizeMake(0, 1), 4, shadow.CGColor);
    }
    CGContextDrawPath(c, kCGPathFillStroke);
}


void CGDrawRoundRect(CGContextRef c,CGRect roundRect,UIRectCorner corners,CGSize cornerRadii,UIColor* bgcolor,UIColor *borderColor)
{
    CGDrawRoundRectWithParam(c, roundRect, corners, cornerRadii, bgcolor, borderColor, nil);
}


CGRect TextDrawableRect(CGRect boundingRect, CGPoint point, int nAnchor,UIFont *font)
{
    CGRect rt;
    int nX = point.x;
    int nY = point.y;
    
    int contentWidth = boundingRect.size.width;
    if (nAnchor&NSTextAlignmentCenter)
    {
        int n = contentWidth-nX;
        if (nX > n && n > 0)
        {
            rt.origin.x = nX-n;
            rt.size.width = 2*n;
        }
        else
        {
            rt.origin.x = 0;
            rt.size.width = 2*nX;
        }
    }
    else if (nAnchor&NSTextAlignmentRight)
    {
        rt.origin.x = 0;
        rt.size.width = nX;
    }
    else
    {
        rt.origin.x = nX;
        rt.size.width = contentWidth-nX;
        if (rt.size.width < 0)
        {
            rt.size.width = contentWidth;
        }
    }
    
    int nHeightFont = font.lineHeight;
    
    if (nAnchor & MSTextVerticalAlignmentCenter)
    {
        rt.origin.y = nY-.5 * nHeightFont;
        rt.size.height = nHeightFont;
    }
    else if (nAnchor & MSTextVerticalAlignmentBottom)
    {
        rt.origin.y = nY-nHeightFont;
        rt.size.height = nHeightFont;
    }
    else
    {
        rt.origin.y = nY;
        rt.size.height = nHeightFont;
    }
    return rt;
}


void CGDrawSampleGroupCell(CGContextRef c,CGRect roundRect,UIRectCorner corners,CGSize cornerRadii)
{
    CGDrawSampleGroupCellWithColor(c, roundRect, corners,cornerRadii, [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1], NO);
}

void CGDrawSampleGroupCellWithColor(CGContextRef c,CGRect roundRect,UIRectCorner corners,CGSize cornerRadii,UIColor* bgcolor,BOOL withBorder)
{
    UIColor *color = withBorder ? [UIColor colorWithWhite:30/255.0 alpha:.9] : nil;
    CGDrawRoundRect(c, roundRect, corners,cornerRadii, bgcolor, color);
}


# pragma mark - 画BS相关的图形

void CGDrawTriBS(CGContextRef context, char bBS, int nX, int nY, UIColor *color)
{
    if(bBS == 0)
    {
        CGDrawFillDiamond(context, nX, nY, 9, 4, color);
    }
    else
    {
        CGDrawFillTrianle(context, bBS>0 ? MSArrowDirectionUp : MSArrowDirectionDown, CGRectMake(nX-4,nY,9,8), color);
    }
}


void CGDrawFenbiTriBS(CGContextRef context, char bBS, int nX, int nY, UIColor *color)
{
    if(bBS == 0)
    {
        CGDrawFillDiamond(context, nX, nY, 4, 2, color);
    }
    else
    {
        CGDrawFillTrianle(context, bBS>0 ? MSArrowDirectionUp : MSArrowDirectionDown, CGRectMake(nX-2,nY,4,3), color);
    }
}


void CGDrawBSArrow(CGContextRef context, char cDirect, int nX, int nY, UIColor *color)
{
    CGContextMoveToPoint(context, nX, nY);
    CGPoint linePoints[7];
    if (cDirect > 0)
    {
        linePoints[0] = CGPointMake(nX-4, nY + 4);
        linePoints[1] = CGPointMake(nX-1.5, nY + 4);
        linePoints[2] = CGPointMake(nX-1.5, nY + 8);
        linePoints[3] = CGPointMake(nX+1.5, nY + 8);
        linePoints[4] = CGPointMake(nX+1.5, nY + 4);
        linePoints[5] = CGPointMake(nX+4, nY + 4);
        linePoints[6] = CGPointMake(nX, nY);
    }
    else
    {
        linePoints[0] = CGPointMake(nX-4, nY - 4);
        linePoints[1] = CGPointMake(nX-1.5, nY - 4);
        linePoints[2] = CGPointMake(nX-1.5, nY - 8);
        linePoints[3] = CGPointMake(nX+1.5, nY - 8);
        linePoints[4] = CGPointMake(nX+1.5, nY - 4);
        linePoints[5] = CGPointMake(nX+4, nY - 4);
        linePoints[6] = CGPointMake(nX, nY);
    }
    CGContextAddLines(context,linePoints,7);
    [color setFill];
    CGContextDrawPath(context, kCGPathFill);
}


void CGDrawBSPoint(CGContextRef context, char cDirect, int nX, int nY, NSString *bImageName, NSString *sImageName)
{
    UIImage *img = nil;
    if (cDirect>0) {
        img = [UIImage imageNamed:bImageName];
    }
    else{
        img = [UIImage imageNamed:sImageName];
    }
    
    CGContextDrawImage(context, CGRectMake(nX-3, nY-3, 6, 6), img.CGImage);
}

CGRect Point2Rect(CGRect boundingRect, CGPoint point, int nAnchor,UIFont *font)
{
    CGRect rt;
    int nX = point.x;
    int nY = point.y;
    
    int contentWidth = boundingRect.size.width;
    if (nAnchor&NSTextAlignmentCenter)
    {
        rt.origin.x = 0;
        rt.size.width = 2*nX;
    }
    else if (nAnchor&NSTextAlignmentRight)
    {
        rt.origin.x = 0;
        rt.size.width = nX;
    }
    else
    {
        rt.origin.x = nX;
        rt.size.width = contentWidth-nX;
        if (rt.size.width < 0)
        {
            rt.size.width = contentWidth;
        }
    }
    
    int nHeightFont = font.lineHeight;
    
    if (nAnchor & MSTextVerticalAlignmentCenter)
    {
        rt.origin.y = nY-.5 * nHeightFont;
        rt.size.height = nHeightFont;
    }
    else if (nAnchor & MSTextVerticalAlignmentBottom)
    {
        rt.origin.y = nY-nHeightFont;
        rt.size.height = nHeightFont;
    }
    else
    {
        rt.origin.y = nY;
        rt.size.height = nHeightFont;
    }
    return rt;
}
