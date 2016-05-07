//
//  MSTextSegmentCell.m
//  UIDemo
//
//  Created by Samuel on 15/4/23.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSTextSegmentCell.h"
#import "NSString+drawing.h"
#import "MSContext.h"
#import <EMSpeed/MSUIKitCore.h>

@interface MSTextSegmentCellObject()
@property (nonatomic, assign) Class cellClass;
@end

@implementation MSTextSegmentCellObject

- (instancetype)initWithCellClass:(Class)cellClass
{
    self = [super init];
    if (self) {
        _cellClass = cellClass;
    }
    return self;
}

+ (instancetype)objectWithCellClass:(Class)cellClass
{
    return [[self alloc] initWithCellClass:cellClass];
}

- (Class)cellClass
{
    return _cellClass;
}

@end


@implementation MSTextSegmentCell
@synthesize selected = _selected;
@synthesize seperateLayer;
@synthesize lineInsets;

- (instancetype)initWithText:(NSString *)object
{
    return [self initWithSegmentObject:(NSObject<MSSegmentCellObject> *)object];
}

- (instancetype)initWithSegmentObject:(NSObject<MSSegmentCellObject> *)object
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.text = (NSString *)object;
        self.seperateLayer = [CALayer layer];
        self.seperateLayer.contentsScale = [UIScreen mainScreen].scale;
        self.seperateLayer.hidden = YES;
        [self.layer addSublayer:self.seperateLayer];
        self.lineInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        
        self.seperateLayer.backgroundColor = RGB(0xe5, 0xe5, 0xe5).CGColor;
        self.font = [UIFont systemFontOfSize:15];
        self.selectedTextColor = RGB(0x46, 0x90, 0xef);
        self.normalTextColor = RGB(0x20, 0x20, 0x20);
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.seperateLayer.frame = CGRectMake(self.frame.size.width-1,self.lineInsets.top , 1, self.frame.size.height - self.lineInsets.top - self.lineInsets.bottom);
}

- (void)drawRect:(CGRect)rect
{
    UIFont *font =  self.font;
    UIColor *textColor = _selected ? self.selectedTextColor : self.normalTextColor;
    [textColor set];
    [self.text ms_drawAtPoint:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
                 boundingRect:rect
                  withFont:font
                     color:textColor
                  aligment:NSTextAlignmentCenter | MSTextVerticalAlignmentCenter];
}

- (BOOL)shouldUpdateCellWithObject:(id)object
{
    return YES;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay];
}

@end