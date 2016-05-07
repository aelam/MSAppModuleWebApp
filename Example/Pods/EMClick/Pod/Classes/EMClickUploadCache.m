//
//  EMClickUploadCache.m
//  Pods
//
//  Created by Mac mini 2012 on 15/12/15.
//
//

#import "EMClickUploadCache.h"


@implementation EMClickUploadCache

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    self = [super init];
    if (self) {
        _identifier = identifier;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.pageViews forKey:@"pageViews"];
    [encoder encodeObject:self.pageEvents forKey:@"pageEvents"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
//    [encoder encodeObject:self.taskIdentifier forKey:@"taskIdentifier"];
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.pageViews = [decoder decodeObjectForKey:@"pageViews"];
        self.pageEvents = [decoder decodeObjectForKey:@"pageEvents"];
        _identifier = [decoder decodeObjectForKey:@"identifier"];
//        self.taskIdentifier = [decoder decodeObjectForKey:@"taskIdentifier"];
    }
    return self;
}


@end