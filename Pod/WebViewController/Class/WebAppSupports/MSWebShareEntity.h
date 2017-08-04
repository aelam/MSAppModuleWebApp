//
//  MSWebShareEntity.h
//  Pods
//
//  Created by ryan on 03/08/2017.
//
//

#import <Foundation/Foundation.h>

@interface MSWebShareEntity : NSObject

@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) NSString *shareDescription;
@property (nonatomic, strong) NSString *shareUrl;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, strong) NSString *shareImageUrl;
@property (nonatomic, strong) NSString *callback;
@property (nonatomic, assign) NSInteger type;

@end
