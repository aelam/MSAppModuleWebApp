//
//  EMCPageView.m
//  EMClickDemo
//
//  Created by flora on 15/9/15.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "EMCPageView.h"
#import <EMSpeed/NSDictionary+JSONString.h>

@implementation EMCPageView

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.sourceview forKey:@"sourceview"];
    [encoder encodeObject:self.pageId forKey:@"pageId"];
    [encoder encodeObject:self.enterDate forKey:@"enterDate"];
    [encoder encodeObject:self.exitDate forKey:@"exitDate"];
    [encoder encodeFloat:self.duration forKey:@"duration"];
    [encoder encodeObject:self.attributes forKey:@"attributes"];
    [encoder encodeObject:self.attributeString forKey:@"attributeString"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.sourceview = [decoder decodeObjectForKey:@"sourceview"];
        self.pageId = [decoder decodeObjectForKey:@"pageId"];
        self.enterDate = [decoder decodeObjectForKey:@"enterDate"];
        self.exitDate = [decoder decodeObjectForKey:@"exitDate"];
        self.duration = [decoder decodeFloatForKey:@"duration"];
        self.attributes = [decoder decodeObjectForKey:@"attributes"];
        self.attributeString = [decoder decodeObjectForKey:@"attributeString"];
    }
    return self;
}

+ (instancetype)pageWithSourceId:(NSString *)srouceId
                          pageId:(NSString *)pageId
{
    EMCPageView *pageView = [[EMCPageView alloc] init];
    pageView.sourceview = srouceId;
    pageView.pageId    = pageId;
    pageView.enterDate = [NSDate date];
    return pageView;
}

- (void)finish
{
    self.exitDate = [NSDate date];
}

- (BOOL)isFinished
{
    if (self.exitDate)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (NSString *)attributeString
{
    if (!self.attributes || [[self.attributes allKeys] count] == 0) {
        return @"";
    }
    NSString *jsonString = [self.attributes jsonString];
    return jsonString;

}

@end
