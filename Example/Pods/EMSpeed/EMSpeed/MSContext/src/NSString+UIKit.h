//
//  NSString+MSDraw.h
//  Pods
//
//  Created by ryan on 15/10/23.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MSSize)

/**
 *  根据字体和尺寸, 计算字符串尺寸
 *
 *  @param font  字体大小
 *  @param asize 容器最大尺寸
 *
 *  @return 尺寸
 */
- (CGSize)ms_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize;


/**
 *  根据字体和尺寸, 计算字符串高度
 *
 *  @param font  字体大小
 *  @param asize 容器最大尺寸
 *
 *  @return 字符串高度
 */
- (CGFloat)ms_heightWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize;


/**
 *  根据字体和尺寸, 计算字符串宽度
 *
 *  @param font  字体大小
 *  @param asize 容器最大尺寸
 *
 *  @return 字符串宽度
 */
- (CGFloat)ms_widthWithFont:(UIFont *)font constrainedToSize:(CGSize)maxSize;


@end

@interface NSString (MSDraw)

@end