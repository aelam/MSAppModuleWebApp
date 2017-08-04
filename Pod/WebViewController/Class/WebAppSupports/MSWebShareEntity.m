//
//  MSWebShareEntity.m
//  Pods
//
//  Created by ryan on 03/08/2017.
//
//

#import "MSWebShareEntity.h"

@implementation MSWebShareEntity

+ (instancetype)shareEntityWithParameters:(NSDictionary *)parameters {
    if(![parameters isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSString *title = parameters[@"title"];
    NSString *content = parameters[@"content"];
    NSString *postUrl = parameters[@"url"];
    NSString *imageUrl = parameters[@"imageUrl"];
    NSInteger socialType = [parameters[@"socialType"] integerValue];
    NSString *callback = parameters[@"callback"];
    NSString *iconUrl = parameters[@"iconUrl"];
    
    MSWebShareEntity *shareEntity = [[MSWebShareEntity alloc] init];
    
    shareEntity.shareTitle = title;
    shareEntity.shareDescription = content;
    shareEntity.shareUrl = postUrl;
    shareEntity.shareImageUrl = imageUrl;
    shareEntity.type = socialType;

    shareEntity.callback = callback;
    shareEntity.iconUrl = iconUrl;
    
    return shareEntity;
}


@end
