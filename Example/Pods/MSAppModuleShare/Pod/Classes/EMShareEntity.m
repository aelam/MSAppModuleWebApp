//
//  EMShareEntity.m
//  EMStock
//
//  Created by xoHome on 14/11/27.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "EMShareEntity.h"
#import "NSDictionary+Query.h"

@implementation EMShareEntity

static NSMutableDictionary *defaultParameters;

+ (void)setDefaultURLParameters:(NSDictionary *)parameters {
    if (defaultParameters == nil) {
        defaultParameters = [NSMutableDictionary dictionary];
    }
    [defaultParameters addEntriesFromDictionary:parameters];
}

- (id)initShareEntityTitle:(NSString *)title Description:(NSString *)description Image:(UIImage *)image Url:(NSString *)url ImageUrl:(NSString *)imageUrl
{
    self = [super init];
    
    if (!self) {
        return self;
    }
    
    self.shareTitle = title;
    self.shareDescription = description;
    self.shareImage = image;
    self.shareUrl = [url stringByAppendingParameters:defaultParameters];;
    self.shareImageUrl = imageUrl;
 
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                  description:(NSString *)description
                         icon:(UIImage *)icon
                        image:(UIImage *)image
                          url:(NSString *)url {
    if (self = [super init]) {
        self.shareUrl = url;
        self.shareTitle = title;
        self.shareImageUrl = self.shareImageUrl;
        self.shareDescription = description;
        self.iconImage = icon;
        self.shareImage = image;
    }
    
    return self;
}

@end
