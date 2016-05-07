//
//  UITableView+cellAction.m
//  ymStock
//
//  Created by deng flora on 6/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UITableView+CellAction.h"


@implementation UITableView(CellAction)

- (void)tableViewCell:(UITableViewCell *)cell scrollToVisibleWithVisibleHeight:(CGFloat)visibleHeight
{
	CGRect rect = cell.frame;
	
	//距离可视区上边缘的距离
	CGFloat beginy = rect.origin.y - self.contentOffset.y;
	CGFloat endy = beginy + rect.size.height;
	
	//不在可视区域内，需要动画将当前响应cell滑动到可视区域内
	if (!(beginy >= 0 && beginy < visibleHeight && endy < visibleHeight)) 
	{		
		NSUInteger absinterval  = floor(.5*visibleHeight - .5*cell.frame.size.height);
		CGPoint offset = self.contentOffset;
		offset.y -= (absinterval - beginy);
		[self setContentOffset:offset animated:YES];
	}
}

@end

