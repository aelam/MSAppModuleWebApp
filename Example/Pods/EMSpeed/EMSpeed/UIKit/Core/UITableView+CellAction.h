//
//  UITableView+CellAction.h
//  ymStock
//
//  Created by deng flora on 6/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

// Deprecated

#import <UIKit/UIKit.h>

@interface UITableView(cellAction)

/**此方法用来实行，当cell中有输入框等响应有弹出视图的情况，当点击cell中的control 会弹出一个弹出层，需要将此cell滚动至可视范围内
 *参数 cell：当前control所在cell；
 *参数 visibleHeight :当前可视范围的高度
 */
- (void)tableViewCell:(UITableViewCell *)cell scrollToVisibleWithVisibleHeight:(CGFloat)visibleHeight;

@end
