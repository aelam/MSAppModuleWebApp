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

- (instancetype)init {
    if (self = [super init]) {
        self.imageEdgeInsets = UIEdgeInsetsMake(-3, 0, 0, 0);
    }
    return self;
}

- (void)setMenuItem:(MSCustomMenuItem *)menuItem {
    if(_menuItem != menuItem) {
        _menuItem = menuItem;
        
        __weak __typeof(self) weakSelf = self;
        
        UIColor *color = self.tintColor;
        if (_menuItem.tintColor) {
            color = [UIColor colorWithHexString:_menuItem.tintColor];
        }
        
        NSString *icon = [menuItem icon];
        
        if ([icon length] > 0) {
            if ([icon hasPrefix:@"http"]) {
                [self sd_setImageWithURL:[NSURL URLWithString:icon] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [weakSelf _setImage:image withTintColor:color];
                }];
            } else {
                icon = [icon stringByReplacingOccurrencesOfString:@".png" withString:@""];
                UIImage *image = [UIImage imageNamed:icon];
                [weakSelf _setImage:image withTintColor:color];
            }
        } else {
            [self setTitleColor:[weakSelf tintColor] forState:UIControlStateNormal];
            
            self.titleLabel.font = [UIFont systemFontOfSize:14];
            [self setTitle:[menuItem title] forState:UIControlStateNormal];
            [weakSelf sizeToFit];
        }
    }
}

- (void)_setImage:(UIImage *)image withTintColor:(UIColor *)color {
    UIImage *newImage = [image rt_tintedImageWithColor:color];
    UIImage *newImage2 = [self resizeImage:newImage newSize:CGSizeMake(24, 24)];
    [self setImage:newImage2 forState:UIControlStateNormal];
    [self sizeToFit];
    [self setFrame:CGRectMake(0, 0, 42, 30)];
}

- (UIImage *)resizeImage:(UIImage *)originImage newSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [originImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
