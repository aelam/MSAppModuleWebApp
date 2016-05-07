//
//  EMScrollControl.m
//  EMStock
//
//  Created by futing li on 11-12-1.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/CoreAnimation.h>
#import "MSRadioControl.h"
#import <EMSpeed/MSUIKitCore.h>
#import <EMSpeed/MSContext.h>

@implementation MSRadioControl



- (instancetype)initWithTitles:(NSArray *)titleArray
{
    self = [self initWithTitle:nil radioTitles:titleArray];
    if (self) {
        
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
        radioTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        _title = title;
        _titles = [[NSArray alloc] initWithArray:titles];
        _isSelectedRadios = [[NSMutableArray alloc]init];
        _selectedIndex = -1;
         self.backgroundColor = [UIColor clearColor];

        for (int i = 0; i < titles.count; i ++)
        {
            if (i == _selectedIndex)
                [_isSelectedRadios addObject:[NSNumber numberWithBool:YES]]; //初始化第一个被选中
            else
                [_isSelectedRadios addObject:[NSNumber numberWithBool:NO]];
        }
        
        if (_title && [_title length]>0) {
            UILabel *label = [self defaultTitleLabel];
            [self setTitleLabel:label];
            label.text = _title;
            _titleLabel = label;
        }
        
        _radios = [NSMutableArray array];
        
        for (int i = 0; i < _titles.count; i ++)
        {
            MSRadioButton *radioBtn = [[self radioClass] radioWithTitle:[_titles objectAtIndex:i] target:self action:@selector(radioBtnClick:)];
            radioBtn.tag = kRadioButtonTag + i;
            radioBtn.isSelected = (i == _selectedIndex);
            [self addSubview:radioBtn];
            
            [_radios addObject:radioBtn];
        }
        
        self.radioGroupEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
        self.countPerRow = 3;
        self.lineHeight = 30;
        _onImage = [MSRadioButton defaultOnImage];
        _offImage = [MSRadioButton defaultOffImage];
    }
    return self;
}

- (Class)radioClass
{
    return [MSRadioButton class];
}

- (void)setTitleLabel:(UILabel *)titleLabel
{
    [_titleLabel removeFromSuperview];
    _titleLabel = titleLabel;
    [self addSubview:_titleLabel];
}

-(UILabel *)titleLabel
{
    return _titleLabel;
}

- (UILabel *)defaultTitleLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont systemFontOfSize:13];
    label.frame = CGRectZero;
    label.numberOfLines = 10;
    
    return label;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_titleLabel && CGRectEqualToRect(_titleLabel.frame, CGRectZero)) {
        _titleLabel.frame = CGRectMake(10, 0, self.frame.size.width-10*2, 1000);
        CGSize maximumLabelSize = CGSizeMake(self.frame.size.width-10*2, FLT_MAX);

        NSDictionary *dict = @{ NSFontAttributeName : _titleLabel.font};
        CGRect rect = [_titleLabel.text boundingRectWithSize:maximumLabelSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        
        CGRect newFrame = _titleLabel.frame;
        newFrame.size.height = rect.size.height;//expectedLabelSize.height;
        _titleLabel.frame = newFrame;
    }
    
    CGFloat maxTextWidth = [self calculateMaxRaidoTextWidth];
    
    
    MSRadioButton *radio = nil;
    
    if ([_radios count] > 0) {
        radio = [_radios objectAtIndex:0];
    }
    
    CGFloat btnWidth = _onImage.size.width + maxTextWidth + radio.titleEdgeInsets.left + radio.imageEdgeInsets.right;
    CGFloat lineHeight = self.lineHeight;
    CGFloat btnHeight = 20; // 按钮高度
    CGFloat topY = 0;
        
    CGFloat btnBetweenSize = floor(_spacing >0 ? _spacing : ((self.frame.size.width - btnWidth * self.countPerRow - self.radioGroupEdgeInsets.left - self.radioGroupEdgeInsets.right) / (self.countPerRow - 1)));
    
    for (int i = 0; i < _titles.count; i ++)
    {
        UIView *button = [self viewWithTag:kRadioButtonTag + i];
        CGFloat begin_x = floorf(self.radioGroupEdgeInsets.left);
        if (self.countPerRow > 1) {
            begin_x += floorf((btnWidth + btnBetweenSize) * (i % self.countPerRow));
        }
        
        CGFloat begin_y = floorf(lineHeight * (i / self.countPerRow)) + CGRectGetHeight(_titleLabel.frame) + self.radioGroupEdgeInsets.top;
        button.frame = CGRectMake(begin_x, begin_y, btnWidth, btnHeight);
        topY = CGRectGetMaxY(button.frame);
    }
    
    CGRect frame = self.frame;
    frame.size.height = topY+self.radioGroupEdgeInsets.bottom;
    self.frame = frame;
    
}


- (float)calculateMaxRaidoTextWidth
{
    MSRadioButton *radio = nil;
    
    if ([_radios count] > 0) {
        radio = [_radios objectAtIndex:0];
    }
    
    CGFloat maxWidth = 0;
    UIFont *font = radio.titleLabel.font;
    for (int i = 0; i < _titles.count; i ++) {
        NSString *title = [_titles objectAtIndex:i];
        NSDictionary *dict = @{ NSFontAttributeName : font};
        CGSize maximumLabelSize = CGSizeMake(self.frame.size.width-10*2, FLT_MAX);
        CGRect rect = [title boundingRectWithSize:maximumLabelSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        maxWidth = MAX(ceilf(rect.size.width), maxWidth);
    }
    
    CGFloat spaceH = 10; // raido的固定间隔
    CGFloat maxOutside = ceilf((self.frame.size.width - self.radioGroupEdgeInsets.left - self.radioGroupEdgeInsets.right - (_spacing + spaceH) * (self.countPerRow - 1) - _onImage.size.width * self.countPerRow) / self.countPerRow);
    maxWidth = MIN(maxWidth, maxOutside);
    
    return maxWidth;
}

-(void)radioBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    long index = btn.tag - kRadioButtonTag;

    if (_selectedIndex != index)
    {//将之前选中的不选中
        if (_selectedIndex>=0) {
            [_isSelectedRadios replaceObjectAtIndex:_selectedIndex withObject:[NSNumber numberWithBool:NO]];
        }
        [_isSelectedRadios replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:YES]];
        MSRadioButton *preButton     = (MSRadioButton *)[self viewWithTag:kRadioButtonTag + _selectedIndex];
        MSRadioButton *currentButton = (MSRadioButton *)[self viewWithTag:kRadioButtonTag + index];
        _selectedIndex = index;
        
        preButton.isSelected = NO;
        currentButton.isSelected = YES;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(radioControl:didClickRadio:)])
       [self.delegate radioControl:self didClickRadio:sender];
}

- (void)setOnImage:(UIImage *)onImage
{
    if (onImage) {
        _onImage = onImage;
        for (int i=0; i<[_radios count]; i++) {
            MSRadioButton *r = [_radios objectAtIndex:i];
            r.onImage = onImage;
            
            [r setNeedsDisplay];
        }
    }
}

- (void)setOffImage:(UIImage *)offImage
{
    if (offImage) {
        _offImage = offImage;
        for (int i=0; i<[_radios count]; i++) {
            MSRadioButton *r = [_radios objectAtIndex:i];
            r.offImage = offImage;
            
            [r setNeedsDisplay];
        }
    }
}

@end




@implementation MSRadioButton

+ (MSRadioButton *)radioWithTitle:(NSString *)title
                    onImage:(UIImage *)onImage
                   offImage:(UIImage *)offImage
                     target:(id)target
                     action:(SEL)selector
{
    MSRadioButton *radioBtn = [MSRadioButton buttonWithType:UIButtonTypeCustom];
    radioBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [radioBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [radioBtn setTitle:title forState:UIControlStateNormal];
    [radioBtn setImage:offImage forState:UIControlStateNormal];
    radioBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [radioBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    radioBtn.onImage = onImage ? onImage : [MSRadioButton defaultOnImage];
    radioBtn.offImage = offImage ? offImage : [MSRadioButton defaultOffImage];
    radioBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
    radioBtn.frame = CGRectMake(0, 0, 50, 20);
    return radioBtn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.frame;
    frame.size.width = self.frame.size.width;
    frame.size.height = self.frame.size.height;
}

+ (MSRadioButton *)radioWithTitle:(NSString *)title
                     target:(id)target
                     action:(SEL)selector
{
    return [MSRadioButton radioWithTitle:title onImage:nil offImage:nil target:target action:selector];
}

+ (UIImage *)defaultOnImage
{
    return [UIImage imageNamed:MSUIResName(@"radio_on")];
}

+ (UIImage *)defaultOffImage
{
    return [UIImage imageNamed:MSUIResName(@"radio_off")];
}

-(void)setIsSelected:(BOOL)isSelected
{
    [self setImage:isSelected ? _onImage : _offImage forState:UIControlStateNormal];
}

- (void)setOnImage:(UIImage *)onImage
{
    _onImage = onImage;
    if (_isSelected) {
        [self setImage:_onImage forState:UIControlStateNormal];
    }
}

- (void)setOffImage:(UIImage *)offImage
{
    _offImage = offImage;
    if (!_isSelected) {
        [self setImage:_offImage forState:UIControlStateNormal];
    }
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end