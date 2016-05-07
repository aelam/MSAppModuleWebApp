 //
//  EMCommonMetrics.m
//  EMStock
//
//  Created by flora on 14-9-11.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSCoreMetrics.h"

CGRect MSScreenBounds(void) {
    return [[UIScreen mainScreen] bounds];
}

CGFloat MSScreenHeight(void) {
    return [[UIScreen mainScreen] bounds].size.height;
}


CGFloat MSScreenWidth(void) {
    return [[UIScreen mainScreen] bounds].size.width;
}

CGRect MSContentFrame(void) {
    return [[UIScreen mainScreen] applicationFrame];
}

CGFloat MSContentHeight(void) {
    return [[UIScreen mainScreen] applicationFrame].size.height;
}


CGFloat MSContentWidth(void) {
    return [[UIScreen mainScreen] applicationFrame].size.width;
}



CGFloat MSNavigationBarHeight(void)
{
    return 44.0f;
}


CGFloat MSTabBarHeight(void)
{
    return 49.0f;
}


CGFloat MSStatusBarHeight(void)
{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}


CGFloat MSScreenScale(void)
{
    return [[UIScreen mainScreen] scale];
}

CGFloat MSAdaptiveCofficient()
{
    static CGFloat coffient = 0;
    if (coffient == 0)
    {
        coffient = MSScreenWidth()/320.0;
        coffient = [[NSString stringWithFormat:@"%.2f",coffient] floatValue];
    }
    return coffient;
}


CGFloat MSAdjustedWH(CGFloat wh)
{
    return  wh * MSAdaptiveCofficient();
}

CGFloat MSDefaultValueWidth(UIFont *font)
{
    NSString *string = @"-10.00%";
    NSDictionary *attributes = @{NSFontAttributeName: font};
    return [string sizeWithAttributes:attributes].width;
}

