//
//  EMWebErrorView.m
//  Pods
//
//  Created by ryan on 5/23/16.
//
//

#import "EMWebErrorView.h"
#import <Masonry/Masonry.h>
#import <MSThemeKit/MSThemeKit.h>
#import <UIColor-HexString/UIColor+HexString.h>

@interface EMWebErrorView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;

@end

@implementation EMWebErrorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"web_icon_logo"]];
        [self addSubview:self.imageView];

        UIColor *textColor = [UIColor colorWithHexString:@"#8e8e8e"];
        UIFont *textFont = [UIFont systemFontOfSize:12];

        self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = textColor;
        self.titleLabel.font = textFont;
        self.titleLabel.text = @"未获取到内容";
        [self addSubview:self.titleLabel];

        self.subtitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.subtitleLabel.textAlignment = NSTextAlignmentCenter;
        self.subtitleLabel.textColor = textColor;
        self.subtitleLabel.font = textFont;
        self.subtitleLabel.text = @"请点击页面重试";
        [self addSubview:self.subtitleLabel];

        [self setUpdateConstraints];


        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }

    return self;
}

- (void)setUpdateConstraints {

    __weak __typeof(self) superView = self;

    CGSize imageSize = self.imageView.frame.size;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(imageSize);
        make.center.mas_equalTo(superView).centerOffset(CGPointMake(0, -15));
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.imageView.mas_bottom).with.offset(7);
        make.height.mas_equalTo(16);
        make.left.and.right.equalTo(superView);
    }];


    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.titleLabel.mas_bottom).with.offset(1);
        make.height.mas_equalTo(16);
        make.left.and.right.equalTo(superView);
    }];


}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if (self.tapBlock) {
        self.tapBlock();
    }
}

@end
