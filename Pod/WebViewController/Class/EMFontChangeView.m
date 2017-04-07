//
//  EMFontChangeView.m
//  Pods
//
//  Created by ryan on 15/12/2016.
//
//

#import "EMFontChangeView.h"
#import <Masonry/Masonry.h>
#import "UIImage+WebAppBundle.h"

// button size { 52 29 }

static NSInteger const kButtonOffset = 100;

@interface EMFontChangeView ()

@property (nonatomic, strong) IBOutlet UIButton *smallFontButton;
@property (nonatomic, strong) IBOutlet UIButton *middleFontButton;
@property (nonatomic, strong) IBOutlet UIButton *bigFontButton;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttons;

@end


@implementation EMFontChangeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit {
    NSArray *imageNames = @[@"web_font_small",@"web_font_middle",@"web_font_big"];
    
    for (NSInteger i = 0; i < [imageNames count]; i++) {
        [self updateButton:self.buttons[i] withImageName:imageNames[i]];
    }
    
    self.selectedIndex = 0;
    [self updateButtons];
}

- (void)updateButton:(UIButton *)button withImageName:(NSString *)name {
    UIImage *normalImage = [UIImage webAppResourceImageNamed:name];
    UIImage *selectedImage = [UIImage webAppResourceImageNamed:[name stringByAppendingString:@"_selected"]];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
    [button setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [button setBackgroundImage:selectedImage forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [button setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        
        [self updateButtons];
    }
}

- (void)valueChanged:(UIButton *)sender {
    NSInteger selectedIndex = sender.tag - kButtonOffset;

    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        
        [self updateButtons];

        if ([self.actionDelegate respondsToSelector:@selector(MSArtPopView:didPressed:)]) {
            [self.actionDelegate MSArtPopView:(MSArtPopupView *)self.superview didPressed:self];
        }
    }

}

- (void)updateButtons {
    for (UIButton *button in self.buttons) {
        if (button.tag - kButtonOffset == _selectedIndex) {
            button.selected = YES;
        } else {
            button.selected = NO;
        }
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.fontChangeTitleLabel.textColor = _titleColor;
}

@end



