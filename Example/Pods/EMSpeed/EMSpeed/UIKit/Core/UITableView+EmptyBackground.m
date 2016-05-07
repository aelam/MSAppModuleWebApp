//
//  UITableView+EmptyBackground.m
//  QQStock
//
//  Created by futing li on 12-7-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UITableView+EmptyBackground.h"


@implementation UITableView (EmptyBackground)

- (void)toggleEmptyBackgroundWithDataSource:(NSArray *)dataSource
{
    [self toggleEmptyBackgroundWithDataSource:dataSource tip:@"暂无数据"];
}

- (void)toggleEmptyBackgroundWithDataSource:(NSArray *)dataSource tip:(NSString*)tipString
{
    if (dataSource && [dataSource count]) {
        if (self.backgroundView) {
            [self.backgroundView removeFromSuperview];
            self.backgroundView = nil;
        }
        self.scrollEnabled = YES;
    }else {
        if (!self.backgroundView) {
            CGRect rect = [self bounds];
            
            self.backgroundView = [[UIView alloc] initWithFrame:rect];
            UILabel *emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
            emptyLabel.backgroundColor = [UIColor clearColor];
            emptyLabel.textColor = [UIColor grayColor];
            emptyLabel.font = [UIFont boldSystemFontOfSize:16];
            emptyLabel.textAlignment = NSTextAlignmentCenter;
            emptyLabel.text = tipString;
            emptyLabel.lineBreakMode = NSLineBreakByCharWrapping;
            emptyLabel.center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
            [self.backgroundView addSubview:emptyLabel];
        }
        self.scrollEnabled = NO;
    }
}

@end
