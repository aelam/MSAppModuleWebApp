//
//  UIView+autoLayout.m
//  EMStock
//
//  Created by xoHome on 14-10-6.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

- (void)ms_addConstraintsWithContentInsets:(UIEdgeInsets)contentInsets
                                subView:(UIView *)subView
{
    NSString *HFormatString = [NSString stringWithFormat:@"|-%d-[subView]-%d-|",(int)contentInsets.left,(int)contentInsets.right];
    NSString *VFormatString = [NSString stringWithFormat:@"V:|-%d-[subView]-%d-|",(int)contentInsets.top,(int)contentInsets.bottom];
    
    NSMutableArray *tmpConstraints = [NSMutableArray array];
    //设置竖向的layout
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:HFormatString
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:NSDictionaryOfVariableBindings(subView)]];
    
    [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:VFormatString
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:NSDictionaryOfVariableBindings(subView)]];
    
    for (NSLayoutConstraint *constraint in [self constraints])
    {
        if ([constraint.firstItem isEqual:subView])
        {
            [self removeConstraint:constraint];
        }
    }
    
    [self addConstraints:tmpConstraints];
}

@end
