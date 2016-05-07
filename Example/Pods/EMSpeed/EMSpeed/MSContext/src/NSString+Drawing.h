//
//  NSString+drawing.h
//  EMStock
//
//  Created by flora on 14-9-11.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSContext.h"

@interface NSString (Drawing)

/**
 *  在某个点画文字
 *
 *  @param point 画字符串起始点
 *  @param font  字体
 */
- (void)ms_drawAtPoint:(CGPoint)point withFont:(UIFont *)font;


/**
 *  在某个点画文字
 *
 *  @param point 画字符串起始点
 *  @param font  字体
 *  @param color 颜色
 */
- (void)ms_drawAtPoint:(CGPoint)point withFont:(UIFont *)font withColor:(UIColor*)color;


/**
 *  在某个点画文字
 *
 *  @param point      画字符串起始点
 *  @param font       字体
 *  @param color      颜色
 *  @param aligment   居中类型
 *  @param lineHeight 行高
 */
- (void)ms_drawAtPoint:(CGPoint)point
          boundingRect:(CGRect)boundingRect
              withFont:(UIFont *)font
                 color:(UIColor *)color
              aligment:(int)aligment
            lineHeight:(CGFloat)lineHeight;


/**
 *  在某个点画文字
 *
 *  @param point    画字符串起始点
 *  @param font     字体
 *  @param color    颜色
 *  @param aligment 居中类型
 */
- (void)ms_drawAtPoint:(CGPoint)point
          boundingRect:(CGRect)boundingRect
              withFont:(UIFont *)font
                 color:(UIColor *)color
              aligment:(int)aligment;


/**
 *  在某个区域内画文字
 *
 *  @param rect       区域
 *  @param font       字体
 *  @param color      颜色
 *  @param aligment   居中类型
 *  @param lineHeight 行高
 */
- (void)ms_drawInRect:(CGRect)rect
             withFont:(UIFont *)font
                color:(UIColor *)color
             aligment:(int)aligment
           lineHeight:(CGFloat)lineHeight;


/**
 *  在某个区域内画文字
 *
 *  @param rect     区域
 *  @param font     字体
 *  @param color    颜色
 *  @param aligment 行高
 */
- (void)ms_drawInRect:(CGRect)rect
             withFont:(UIFont *)font
                color:(UIColor *)color
             aligment:(int)aligment;


/**
 *  默认行高、默认靠左绘制
 *
 *  @param rect  区域
 *  @param font  字体
 *  @param color 颜色
 */
- (void)ms_drawInRect:(CGRect)rect
             withFont:(UIFont *)font
                color:(UIColor *)color;


/**
 *  根据字体获取字符串的尺寸
 *
 *  @param font 字体
 *
 *  @return 字符串尺寸
 */
- (CGSize)ms_sizeWithFont:(UIFont *)font;


/**
 *  画文字
 *
 *  @param rect      区域
 *  @param attribute 属性
 */
- (void)ms_drawInRect:(CGRect)rect withAttributes:(NSDictionary *)attribute;

@end
