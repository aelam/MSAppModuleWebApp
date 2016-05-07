//
//  EMShareEntity.h
//  EMStock
//
//  Created by xoHome on 14/11/27.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EMSocialType)
{
    EMSocialTypeAll         = 0,    //分享全部
    EMSocialTypeWeChat      = 1,    //微信
    EMSocialTypeSinaWeibo   = 2,    //新浪微博
    EMSocialTypeMoments     = 4,    //朋友圈
    EMSocialTypeQQ          = 8,    //QQ
    EMSocialTypeAddress     = 9,    //通讯录
};


@interface EMShareEntity : NSObject

+ (void)setDefaultURLParameters:(NSDictionary *)parameters;

@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) NSString *shareDescription;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *shareImageUrl;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) UIImage *iconImage;   //作为微信分享的缩略图
@property (nonatomic, assign) EMSocialType socialType;
@property (nonatomic, strong) NSString *callback;

- (instancetype)initShareEntityTitle:(NSString *)title Description:(NSString *)description Image:(UIImage *)image Url:(NSString *)url ImageUrl:(NSString *)imageUrl;

- (instancetype)initWithTitle:(NSString *)title
                  description:(NSString *)description
                         icon:(UIImage *)icon
                        image:(UIImage *)image
                          url:(NSString *)url;


@end
