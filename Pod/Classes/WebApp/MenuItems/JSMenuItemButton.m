//
//  JSMenuItemButton.m
//  Pods
//
//  Created by Ryan Wang on 16/5/16.
//
//

#import "JSMenuItemButton.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <UIImage+RTTint/UIImage+RTTint.h>
#import <UIColor-HexString/UIColor+HexString.h>

@implementation JSMenuItemButton

- (void)setMenuItem:(MSCustomMenuItem *)menuItem {
    if(_menuItem != menuItem) {
        _menuItem = menuItem;
        
        __weak __typeof(self) weakSelf = self;
        
        UIColor *color = self.tintColor;
        if (_menuItem.tintColor) {
            color = [UIColor colorWithHexString:_menuItem.tintColor];
        }
        
        if ([menuItem icon]) {
            
            self.imageEdgeInsets = UIEdgeInsetsMake(-3, 0, 0, 0);

            [self sd_setImageWithURL:[NSURL URLWithString:[menuItem icon]] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                UIImage *newImage = [image rt_tintedImageWithColor:color];
                UIImage *newImage2 = [self resizeImage:newImage newSize:CGSizeMake(24, 24)];
                [weakSelf setImage:newImage2 forState:UIControlStateNormal];
                [weakSelf sizeToFit];
                [weakSelf setFrame:CGRectMake(0, 0, 42, 30)];
            }];
        } else {
            [self setTitleColor:[weakSelf tintColor] forState:UIControlStateNormal];

            self.titleLabel.font = [UIFont systemFontOfSize:14];
            [self setTitle:[menuItem title] forState:UIControlStateNormal];
            [weakSelf sizeToFit];
        }
    }
}

- (UIImage *)resizeImage:(UIImage *)originImage newSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [originImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
