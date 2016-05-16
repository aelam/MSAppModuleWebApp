//
//  JSMenuItemButton.m
//  Pods
//
//  Created by Ryan Wang on 16/5/16.
//
//

#import "JSMenuItemButton.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation JSMenuItemButton

- (void)setMenuItem:(MSCustomMenuItem *)menuItem {
    if(_menuItem != menuItem) {
        _menuItem = menuItem;
        
        __weak __typeof(self) weakSelf = self;
        if ([menuItem icon]) {
            [self sd_setImageWithURL:[NSURL URLWithString:[menuItem icon]] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [weakSelf sizeToFit];
            }];
        } else {
            [self setTitle:[menuItem title] forState:UIControlStateNormal];
            [weakSelf sizeToFit];
        }
    }
}

@end
