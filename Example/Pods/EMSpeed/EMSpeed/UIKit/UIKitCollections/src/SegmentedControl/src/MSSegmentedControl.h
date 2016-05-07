//
//  UISegmentedControl.h
//  UIKit
//
//  Copyright (c) 2005-2013, Apple Inc. All rights reserved.
//
//自定义segmentcontrol，默认不能滚动，且平均分配每个cell的宽度
//也可通过调用- (void)setWidth:(CGFloat)width forSegmentAtIndex:(NSUInteger)segment 来设定特定segment的宽度，剩余的平均分配
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIControl.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIGeometry.h>
#import <UIKit/UIBarButtonItem.h>
#import "MSSegmentSelectedIndicatorView.h"


enum {
    MSSegmentedControlNoSegment = -1   // segment index for no selected segment
};



@protocol MSSegmentCell;

@interface MSSegmentedControl : UIControl <NSCoding>
{
@protected
    
    // Note: all instance variables will become private in the future. Do not access directly.
    NSMutableArray *_segments;
    NSInteger       _highlightedSegment;
    UIView*         _removedSegment;
    NSMutableArray *_items;
    NSInteger _selectedSegmentIndex;
    CGFloat *_segmentWidths;
    
    UIView<MSSegmentCell> *_highlightedSegmentView;
    MSSegmentSelectedIndicatorView *_selectedView;
}

- (instancetype)initWithItems:(NSArray *)items; // items can be NSStrings or othre struct

@property(nonatomic, assign) MSSegmentSelectedIndicatorStyle selectedIndicatorStyle;

@property(nonatomic,readonly) NSUInteger numberOfSegments;
@property (nonatomic, readonly) UIFont *itemFont;
@property (nonatomic) int didNeedsSeperateLine;//是否需要分隔线,default is no

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)segment animated:(BOOL)animated; // insert before segment number. 0..#segments. value pinned
- (void)insertSegmentWithObject:(id)object  atIndex:(NSUInteger)segment animated:(BOOL)animated;
- (void)removeSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated;
- (void)removeAllSegments;
- (void)setItems:(NSArray *)items;

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment;      // can only have image or title, not both. must be 0..#segments - 1 (or ignored). default is nil
- (NSString *)titleForSegmentAtIndex:(NSUInteger)segment;
- (NSString *)titleForSegmentAtCurrentIndex;

- (void)setSegmentObject:(id)object forSegmentAtIndex:(NSUInteger)segment;       // can only have image or title, not both. must be 0..#segments - 1 (or ignored). default is nil
- (id)segmentObjectForSegmentAtIndex:(NSUInteger)segment;

- (void)setWidth:(CGFloat)width forSegmentAtIndex:(NSUInteger)segment;         // set to 0.0 width to autosize. default is 0.0
- (CGFloat)widthForSegmentAtIndex:(NSUInteger)segment;


- (void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)segment;        // default is YES
- (BOOL)isEnabledForSegmentAtIndex:(NSUInteger)segment;

// ignored in momentary mode. returns last segment pressed. default is UISegmentedControlNoSegment until a segment is pressed
// the UIControlEventValueChanged action is invoked when the segment changes via a user event. set to UISegmentedControlNoSegment to turn off selection
@property(nonatomic) NSInteger selectedSegmentIndex;

- (void)setSelectedSegmentIndexWithTitle:(NSString *)title; // 根据标题找，选中对应的index，如果没找到设置UISegmentedControlNoSegment

/**segment所控制内容区的颜色，用于MSselectedIndicatorStyleMenuContent 状态下的视图对接使用
 */
- (void)setIndicatorBackgroundColor:(UIColor *)color;

- (void)reload;


- (void)setFont:(UIFont *)font;

- (void)updateItems;

- (Class)segmentCellFactoryClass;

/**
 *更新选中效果视图，一般当 selectedIndicatorStyle 重置时，系统会执行方法更新
 *子类可通过复写方法做自定义修改
 */
- (void)updateSelectView;

/**
 *  根据当前类型返回对应选中视图的class
 *
 *  @param style 类型
 *
 *  @return 选中效果视图class
 */
- (Class)selectedViewClassWithStyle:(MSSegmentSelectedIndicatorStyle)style;


@end



