//
//  UINavigationItem+EM.m
//  EMStock
//
//  Created by flora on 14/11/19.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "UINavigationItem+EMBarButtonItem.h"
#import "MSUIKitCoreFunction.h"

@implementation UINavigationItem(EMBarButtonItem)

- (void)setEMLeftBarButtonItem:(UIBarButtonItem *)item
{
    self.leftBarButtonItem = item;
    if (MSOSVersion() >= 7.0)
    {
        if([item.customView isKindOfClass:[UIButton class]])
        {
            ((UIButton *)item.customView).contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
    }
}

- (void)setEMRightBarButtonItem:(UIBarButtonItem *)item
{
    self.rightBarButtonItem = item;
}

@end
