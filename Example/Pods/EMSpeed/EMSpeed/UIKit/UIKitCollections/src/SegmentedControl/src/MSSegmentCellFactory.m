//
//  EMElementFactory.m
//  EMStock
//
//  Created by xoHome on 14-10-7.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSSegmentCellFactory.h"
#import "MSTextSegmentCell.h"


@interface MSSegmentCellFactory()
@property (nonatomic, copy) NSMutableDictionary* objectToCellMap;
@end

@implementation MSSegmentCellFactory

- (instancetype)init {
    if ((self = [super init])) {
        _objectToCellMap = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (UIView<MSSegmentCell> *)segmentCellForSegmentControl:(MSSegmentedControl *)segmentControl
                                                atIndex:(int)index
                                             withObject:(NSObject<MSSegmentCellObject> *)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        MSTextSegmentCell *label = [[MSTextSegmentCell alloc] initWithSegmentObject:object];
        
        return label;
    }
    else
    {
        return [[[object cellClass] alloc] initWithSegmentObject:object];
    }
}

@end




