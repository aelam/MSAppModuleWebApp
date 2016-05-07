//
//  EMNormalSegmentedCell.h
//  EMStock
//
//  Created by xoHome on 14-10-20.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTextSegmentCell.h"

@interface MSImageSegmentedCellObject : MSTextSegmentCellObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;

+ (instancetype)objectWithTitle:(NSString *)title image:(UIImage *)image;

@end

@interface MSImageSegmentedCell : UIView<MSSegmentCell>
{
    MSImageSegmentedCellObject *_object;
}

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;

@end
