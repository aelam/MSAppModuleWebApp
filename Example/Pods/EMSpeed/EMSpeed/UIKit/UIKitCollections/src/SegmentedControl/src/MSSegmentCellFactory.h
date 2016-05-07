//
//  EMElementFactory.h
//  EMStock
//
//  Created by xoHome on 14-10-7.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSBorderView.h"

@class MSTextSegmentCell,MSSegmentedControl;
@protocol MSSegmentCellObject, MSSegmentCell;


@interface MSSegmentCellFactory : NSObject

+ (UIView<MSSegmentCell> *)segmentCellForSegmentControl:(MSSegmentedControl *)segmentControl atIndex:(int)index withObject:(NSObject<MSSegmentCellObject> *)object;

@end


@protocol MSSegmentCellObject <NSObject>
@required
- (Class)cellClass;

@end

@protocol MSSegmentCell <NSObject>
@required
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithSegmentObject:(NSObject<MSSegmentCellObject> *)object;

@optional

//边框线
@property (nonatomic, strong) CALayer *seperateLayer;
 //主要用于指定分隔线离top、bottom的间距
@property (nonatomic, assign) UIEdgeInsets lineInsets;

- (BOOL)shouldUpdateCellWithObject:(id)object;


@end

