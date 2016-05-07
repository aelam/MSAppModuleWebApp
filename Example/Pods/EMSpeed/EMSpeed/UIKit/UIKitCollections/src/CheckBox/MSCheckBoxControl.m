//
//  MSCheckBoxControl.m
//  UI
//
//  Created by Samuel on 15/4/7.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import "MSCheckBoxControl.h"
//#import "MSContext.h"

@implementation MSCheckBoxControl

- (instancetype)initWithTitle:(NSString *)title
     checkBoxTitles:(NSArray *)titleArray
{
    return [[MSCheckBoxControl alloc] initWithTitle:title radioTitles:titleArray];
}

-(instancetype)initWithTitles:(NSArray *)titleArray
{
    return [[MSCheckBoxControl alloc] initWithTitles:titleArray];
}

-(void)radioBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    long index = btn.tag - kRadioButtonTag;
    _selectedIndex = index;
    
    if (_selectedIndex>=0) {
        NSNumber *number = [_isSelectedRadios objectAtIndex:_selectedIndex];
        BOOL flag = [number boolValue];
        flag = !flag;
        [_isSelectedRadios replaceObjectAtIndex:_selectedIndex withObject:[NSNumber numberWithBool:flag]];
        
        MSCheckBoxButton *checkBox = [_radios objectAtIndex:_selectedIndex];
        checkBox.isSelected = flag;
        
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(radioControl:didClickRadio:)])
            [self.delegate radioControl:self didClickRadio:sender];
    }
}

- (Class)radioClass
{
    return [MSCheckBoxButton class];
}

- (void)setCheckBox:(BOOL)isOn atIndex:(int)index
{
    if (index >=0 && index < [_radios count]) {
        MSCheckBoxButton *checkBox = [_radios objectAtIndex:index];
        checkBox.isSelected = isOn;
        [_isSelectedRadios replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:isOn]];
    }
}

@end


@implementation MSCheckBoxButton

+ (MSCheckBoxButton *)checkBoxWithTitle:(NSString *)title
                          onImage:(UIImage *)onImage
                         offImage:(UIImage *)offImage
                           target:(id)target
                           action:(SEL)selector
{
    MSCheckBoxButton *checkBox = [MSCheckBoxButton buttonWithType:UIButtonTypeCustom];
    checkBox.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [checkBox setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [checkBox setTitle:title forState:UIControlStateNormal];
    [checkBox setImage:offImage forState:UIControlStateNormal];
    checkBox.titleLabel.font = [UIFont systemFontOfSize:13];
    [checkBox addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    checkBox.onImage = onImage ? onImage : [MSCheckBoxButton defaultOnImage];
    checkBox.offImage = offImage ? offImage : [MSCheckBoxButton defaultOffImage];
    checkBox.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
    checkBox.frame = CGRectMake(0, 0, 50, 20);
    return checkBox;
}

+ (MSCheckBoxButton *)radioWithTitle:(NSString *)title
                    onImage:(UIImage *)onImage
                   offImage:(UIImage *)offImage
                     target:(id)target
                     action:(SEL)selector
{
    return [MSCheckBoxButton checkBoxWithTitle:title onImage:onImage offImage:offImage target:target action:selector];
}

+ (MSCheckBoxButton *)radioWithTitle:(NSString *)title
                     target:(id)target
                     action:(SEL)selector
{
    return [MSCheckBoxButton checkBoxWithTitle:title target:target action:selector];
}


+ (MSCheckBoxButton *)checkBoxWithTitle:(NSString *)title
                           target:(id)target
                           action:(SEL)selector
{
    return [MSCheckBoxButton checkBoxWithTitle:title onImage:nil offImage:nil target:target action:selector];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.frame;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height;
}

+ (UIImage *)defaultOnImage
{
    return [UIImage imageNamed:@"checkbox_on"];
}

+ (UIImage *)defaultOffImage
{
    return [UIImage imageNamed:@"checkbox_off"];
}

@end