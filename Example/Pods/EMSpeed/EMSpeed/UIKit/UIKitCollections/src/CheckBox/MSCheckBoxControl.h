//
//  MSCheckBoxControl.h
//  UI
//
//  Created by Samuel on 15/4/7.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSRadioControl.h"


/**
    checkBox控制器
 */
@interface MSCheckBoxControl : MSRadioControl


/**
 *  创建checkBox控制器
 *
 *  @param title      标题
 *  @param titleArray 按钮内容数组
 *
 *  @return checkBox控制器
 */
- (instancetype)initWithTitle:(NSString *)title
               checkBoxTitles:(NSArray *)titles;


/**
 *  创建checkBox控制器
 *
 *  @param titleArray 按钮内容数组
 *
 *  @return checkBox控制器
 */
-(instancetype)initWithTitles:(NSArray *)titles;


/**
 *  设置选中/未选中的状态
 *
 *  @param isOn  是否选中
 *  @param index 下标
 */
- (void)setCheckBox:(BOOL)isOn atIndex:(int)index;

@end


/**
 *  MSCheckBoxButton控件
 */
@interface MSCheckBoxButton : MSRadioButton {
    
}


/**
 *  创建MSCheckBoxButton控件
 *
 *  @param title    标题
 *  @param target   点击事件对象
 *  @param selector 点击事件方法
 *
 *  @return MSCheckBoxButton
 */
+ (MSCheckBoxButton *)checkBoxWithTitle:(NSString *)title
                           target:(id)target
                           action:(SEL)selector;


/**
 *  创建MSCheckBoxButton控件
 *
 *  @param title    标题
 *  @param onImage  选中的图片
 *  @param offImage 未选中的图片
 *  @param target   点击事件对象
 *  @param selector 点击事件方法
 *
 *  @return MSCheckBoxButton
 */
+ (MSCheckBoxButton *)checkBoxWithTitle:(NSString *)title
                          onImage:(UIImage *)onImage
                         offImage:(UIImage *)offImage
                           target:(id)target
                           action:(SEL)selector;

@end