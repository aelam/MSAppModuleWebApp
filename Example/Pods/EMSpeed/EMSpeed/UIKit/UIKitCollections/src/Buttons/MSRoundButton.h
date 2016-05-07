//
//  MSRoundButton.h
//  UI
//
//  Created by Samuel on 15/4/2.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  圆角按钮
 */
@interface MSRoundButton : UIButton


/**
 *  圆角类型
 */
@property (nonatomic, assign) UIRectCorner corners;


/**
 *  圆角半径
 */
@property (nonatomic, assign) float cornerRadius;


/**
 *  描边宽度
 */
@property (nonatomic, assign) float borderWidth;


/**
 *  普通状态下的颜色
 */
@property (nonatomic, strong) UIColor *normalStateColor;


/**
 *  按下去高亮的颜色
 */
@property (nonatomic, strong) UIColor *highLightStateColor;


/**
 *  圆角按钮
 *
 *  @param corners             圆角类型
 *  @param cornerRadius        圆角半径
 *  @param normalStateColor    普通状态下的颜色
 *  @param highLightStateColor 高翔状态下的颜色
 *
 *  @return 圆角按钮
 */

+ (MSRoundButton *)roundButtonWithFrame:(CGRect)frame
                                corners:(UIRectCorner)corners
                           cornerRadius:(float)cornerRadius
                       normalStateColor:(UIColor *)normalStateColor
                    highLightStateColor:(UIColor *)highLightStateColor;


+ (MSRoundButton *)roundButtonWithFrame:(CGRect)frame
                                  color:(UIColor *)color;


@end
