//
//  EMShareEntity+Parameters.m
//  Pods
//
//  Created by ryan on 5/17/16.
//
//

#import "EMShareEntity+Parameters.h"

@implementation EMShareEntity (Parameters)

+ (instancetype)shareEntityWithParameters:(NSDictionary *)parameters {
    if(![parameters isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    UIImage *appIcon = [UIImage imageNamed:@"AppIcon60x60"];
    NSString *title = parameters[@"title"];
    NSString *content = parameters[@"content"];
    NSString *postUrl = parameters[@"url"];
    NSString *imageUrl = parameters[@"imageurl"];
    NSInteger socialType = [parameters[@"id"] integerValue];
    NSString *callback = parameters[@"callback"];
    NSString *iconUrl = parameters[@"iconUrl"];
    
    EMShareEntity *shareEntity = [[EMShareEntity alloc] initShareEntityTitle:title Description:content Image:appIcon Url:postUrl ImageUrl:imageUrl];
    shareEntity.callback = callback;
    shareEntity.socialType = socialType;
    shareEntity.iconUrl = iconUrl;
    
    return shareEntity;
}


@end
