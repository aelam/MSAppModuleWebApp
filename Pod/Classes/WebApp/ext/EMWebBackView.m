//
//  EMWebBackView.m
//  ymActionWebView
//
//  Created by flora on 14-7-3.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMWebBackView.h"
#import <MSThemeKit/MSThemeKit.h>
#import <FontAwesome.h>

@implementation EMWebBackView

- (id)initWithParamSupportClose:(BOOL)supportClose
{
    self = [super initWithFrame:CGRectMake(0, 0, 80, 44)];
    if (self) {

        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
        [self setImage:[self backImage] forState:UIControlStateNormal];
        [self setSupportClose:supportClose];
    }
    return self;
}

- (void)setSupportClose:(BOOL)supportClose
{
    if (supportClose != _supportClose)
    {
        _supportClose = supportClose;
    }
    
    if (supportClose)
    {
        if (nil == _closeButton)
        {
            _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_closeButton setTitleColor:[UIColor colorForKey:@"common_navbarItemTextColor"] forState:UIControlStateNormal];
            [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
            _closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
            _closeButton.hidden = YES;
            [self addSubview:_closeButton];
        }
        [self setImage:[self backImage] forState:UIControlStateNormal];
    }
    else
    {
        self.enabled = NO;
        [self setImage:nil forState:UIControlStateNormal];
        _closeButton.hidden = YES;
    }
}

- (void)layoutSubviews 
{
    [super layoutSubviews];
    CGFloat btnWidth   = 0.5 * self.frame.size.width;
    _closeButton.frame = CGRectMake(btnWidth, 0, btnWidth, self.frame.size.height);
}

/**增加点击事件处理
 *target:事件处理target
 *backAction:返回事件处理
 *closeAction:关闭事件处理
 */
- (void)addTarget:(id)target
       backAction:(SEL)backAction
      closeAction:(SEL)closeAction
 forControlEvents:(UIControlEvents)controlEvents
{
    [self  addTarget:target action:backAction forControlEvents:controlEvents];
    [_closeButton addTarget:target action:closeAction forControlEvents:controlEvents];
}

/**根据当前webview的加载状况，更新按键状态
 */
- (void)updateWithCurrentWebView:(UIWebView *)webView
{
    if (_supportClose || [webView canGoBack])
    {
        [self setImage:[self backImage] forState:UIControlStateNormal];
        self.enabled = YES;
    }
    else
    {
        [self setImage:nil forState:UIControlStateNormal];
        self.enabled = NO;
    }
}

- (UIImage *)backImage {
    UIImage *image = [UIImage imageWithIcon:@"em-icon-back"
                            backgroundColor:[UIColor clearColor]
                                  iconColor:[UIColor colorForKey:@"common_navbarItemTextColor"]
                                  iconScale:1//NIScreenScale()
                                    andSize:CGSizeMake(23, 23)];
    return image;
}

- (void)goBack
{
    if (_supportClose)
    {
        _closeButton.hidden = NO;
    }
    
}

@end