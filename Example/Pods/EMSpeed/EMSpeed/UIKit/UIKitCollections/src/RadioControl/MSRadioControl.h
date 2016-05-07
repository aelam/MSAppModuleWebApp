//
//  EMScrollControl.h
//  EMStock
//
//  Created by futing li on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSInteger kRadioButtonTag = 100;

@class MSRadioControl;
@class MSRadioButton;

@protocol MSRadioBoxControlDelegate<NSObject>
@optional
-(void)radioControl:(MSRadioControl*)radioControl
      didClickRadio:(MSRadioButton *)radio;
@end


/**
 *  MSRadioControl, 标题+按钮, 可以自定义标题, 选项, 选中和未选中图片 等
 */
@interface MSRadioControl : UIView{
    NSString *_title;
    NSArray *_titles;
    NSMutableArray *_radios;
    NSMutableArray *_isSelectedRadios;
    NSInteger _selectedIndex;
    UIImage* _onImage;
    UIImage* _offImage;
    UILabel *_titleLabel;
}


/**
 *  委托
 */
@property (nonatomic,assign)id<MSRadioBoxControlDelegate> delegate;


/**
 *  每一行的个数, 默认为3个
 */
@property (nonatomic, assign) NSInteger countPerRow;


/**
 *  选中的下标, -1 都未选中
 */
@property (nonatomic, assign) NSInteger selectedIndex;


/**
 *  缩进默认 (0,20,0,20)
 */
@property (nonatomic, assign) UIEdgeInsets radioGroupEdgeInsets;


/**
 *  间距, 如果不设置, 均分, 默认会有10px的距离
 */
@property (nonatomic, assign) float spacing;


/**
 *  行高 默认30
 */
@property (nonatomic, assign) float lineHeight;


/**
 *  标题, 默认就是一个label
 */
@property (nonatomic, strong) UILabel *titleLabel;


/**
 *  选中时的图片
 */
@property (nonatomic, strong) UIImage *onImage;


/**
 *  未选中时的图片
 */
@property (nonatomic, strong) UIImage *offImage;



/**
 *  初始化方法
 *
 *  @param title      标题
 *  @param titleArray 按钮内容数组
 *
 *  @return raidoControl控件
 */
- (instancetype)initWithTitle:(NSString *)title
        radioTitles:(NSArray *)titles;


/**
 *  初始化方法
 *
 *  @param titleArray 按钮内容数组
 *
 *  @return raidoControl控件
 */
- (instancetype)initWithTitles:(NSArray *)titleArray;


@end



/**
 *  radio控件
 */
@interface MSRadioButton : UIButton {
    
}


/**
 *  选中时的图片
 */
@property (nonatomic, strong) UIImage *onImage;


/**
 *  未选中时的图片
 */
@property (nonatomic, strong) UIImage *offImage;


/**
 *  标题
 */
@property (nonatomic, strong) NSString *title;


/**
 *  是否选中
 */
@property (nonatomic, assign) BOOL isSelected;



/**
 *  MSRadioButton创建
 *
 *  @param title    标题
 *  @param onImage  选中时的图片
 *  @param offImage 未选中时的图片
 *  @param target   点击事件回调对象
 *  @param selector 点击事件响应方法
 *
 *  @return MSRadioButton
 */
+ (MSRadioButton *)radioWithTitle:(NSString *)title
                          onImage:(UIImage *)onImage
                         offImage:(UIImage *)offImage
                           target:(id)target
                           action:(SEL)selector;


/**
 *  MSRadioButton创建
 *
 *  @param title    标题
 *  @param target   点击事件回调对象
 *  @param selector 点击事件响应方法
 *
 *  @return MSRadioButton
 */
+ (MSRadioButton *)radioWithTitle:(NSString *)title
                           target:(id)target
                           action:(SEL)selector;

+ (UIImage *)defaultOnImage;
+ (UIImage *)defaultOffImage;

@end

