//
//  EMSwitchButton.h
//  EMStock
//
//  Created by Samuel on 15/3/19.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSContext.h"


/**
    箭头按钮位置
 *  如果箭头没有显示出来，请查看按钮的bounds和文字的内容是否合适
 */

typedef NS_ENUM(NSInteger, MSArrowButtonPosition) {
     MSArrowButtonPositionLeft,  // 在文字左侧
     MSArrowButtonPositionRight, // 在文字右侧
     MSArrowButtonPositionDown,  // 在文字下方
     MSArrowButtonPositionCenter // 剪头在正中间, 如果没有设置文字, 则默认剪头在中间
};


/**
 *  箭头按钮
 */
@interface  MSArrowButton: UIButton
{
    MSArrowDirection _direct;
}


/**
 *  箭头方向
 */
@property (nonatomic, assign) MSArrowDirection direct;


/**
 *  箭头颜色
 */
@property (nonatomic, strong) UIColor *arrowColor;


/**
 *  箭头高亮颜色
 */
@property (nonatomic, strong) UIColor *arrowHighlightedColor;


/**
 *  箭头阴影颜色, 设置了就有阴影了, 默认没的
 */
@property (nonatomic, strong) UIColor *arrowShadowColor;


/**
 *  箭头阴影高亮颜色, 设置了就有阴影了, 默认没的
 */
@property (nonatomic, strong) UIColor *arrowHighlightedShadowColor;


/**
 *  箭头尺寸
 */
@property (nonatomic, assign) CGSize arrowSize;


/**
 *  箭头位置, 左边, 下边, 右边
 */
@property (nonatomic, assign) MSArrowButtonPosition arrowPos;


/**
 *  箭头坐标, 设置这个位置后, 无视arrowPos
 */
@property (nonatomic, assign) CGPoint arrowOrigin;


/**
 *  箭头图片, 如果设置了这图片则arrowColor, arrowHighlightedColor, arrowShadowColor, arrowHighlightedShadowColor自动无效了
 */
@property (nonatomic, strong) UIImage *imgArrow;


@end

