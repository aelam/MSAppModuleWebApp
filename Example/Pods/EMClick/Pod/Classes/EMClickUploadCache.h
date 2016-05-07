//
//  EMClickUploadCache.h
//  Pods
//
//  Created by Mac mini 2012 on 15/12/15.
//
//

#import <Foundation/Foundation.h>


@interface EMClickUploadCache : NSObject <NSCoding>

@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, strong) NSMutableArray *pageEvents;
@property (nonatomic, strong, readonly) NSString *identifier;
@property (nonatomic, strong) NSString *taskIdentifier;

- (instancetype)initWithIdentifier:(NSString *)identifier;

@end