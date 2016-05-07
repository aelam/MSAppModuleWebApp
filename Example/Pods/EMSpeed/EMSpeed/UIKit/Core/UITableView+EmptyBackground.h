//
//  UITableView+EmptyBackground.h
//  QQStock
//
//  Created by futing li on 12-7-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

// Deprecated

@interface UITableView (EmptyBackground)

- (void)toggleEmptyBackgroundWithDataSource:(NSArray *)dataSource;
- (void)toggleEmptyBackgroundWithDataSource:(NSArray *)dataSource tip:(NSString*)tipString;

@end
