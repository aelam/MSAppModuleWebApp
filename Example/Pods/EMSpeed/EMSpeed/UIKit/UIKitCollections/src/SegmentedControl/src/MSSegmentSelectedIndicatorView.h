//
//  EMSegmentSelectedView.h
//  EMStock
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MSSegmentSelectedIndicatorStyle) {
    MSselectedIndicatorStyleMenuTitle,   // 显示大标题, 下面一条箭头bar
    MSselectedIndicatorStyleMenuContent,  // 显示内容, 下面一条箭头线
};

@interface MSSegmentSelectedIndicatorView : UIView

@property (nonatomic, assign) MSSegmentSelectedIndicatorStyle style;
@property (nonatomic, assign) CGRect selectedRect;
@property (nonatomic, strong) id selectedItem;
@property (nonatomic, assign) CGFloat fixedWidth;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIColor *indicatorBackgroundColor;
@property (nonatomic, strong) UIColor *borderColor;

@end


@interface MSSegmentSelectedIndicatorArrowBar : MSSegmentSelectedIndicatorView

@end


@interface MSSegmentSelectedIndicatorArrowLine : MSSegmentSelectedIndicatorView

@end


