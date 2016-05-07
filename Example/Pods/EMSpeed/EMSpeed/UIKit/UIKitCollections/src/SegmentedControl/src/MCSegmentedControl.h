//
//  MCSegmentedControl.h
//
//  Created by Matteo Caldari on 21/05/2010.
//  Copyright 2010 Matteo Caldari. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MCSegmentedControl : UISegmentedControl {

	NSMutableArray *items;
	
	UIFont  *font;
	UIColor *selectedItemColor;
	UIColor *unselectedItemColor;
	UIColor *selectedBackgroundColor;
	UIColor *unselectedBackgroundColor;
    BOOL _isAction;
}

/**
 * Font for the segments with title
 * Default is sysyem bold 18points
 */
@property (nonatomic, strong)  UIFont  *font;

/**
 * Color of the item in the selected segment
 * Applied to text and images
 */
@property (nonatomic, strong)  UIColor *selectedItemColor;

/**
 * Color of the items not in the selected segment
 * Applied to text and images
 */
@property (nonatomic, strong)  UIColor *unselectedItemColor;

@property (nonatomic, strong)  UIColor *selectedBackgroundColor;
@property (nonatomic, strong)  UIColor *unselectedBackgroundColor;
@property (nonatomic, strong)  NSMutableArray *items;
@property (nonatomic, assign) BOOL isAction;
@end

