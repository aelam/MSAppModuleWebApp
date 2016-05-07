//
//  EMCPageEvent.m
//  EMClickDemo
//
//  Created by flora on 15/9/15.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "EMCPageEvent.h"
#import <EMSpeed/NSDictionary+JSONString.h>

@implementation EMCPageEvent


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.eventId forKey:@"eventId"];
    [encoder encodeInteger:self.eventCount forKey:@"eventCount"];
    [encoder encodeObject:self.attributes forKey:@"attributes"];
    [encoder encodeObject:self.attributeString forKey:@"attributeString"];
    [encoder encodeObject:self.eventDate forKey:@"eventDate"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.eventId = [decoder decodeObjectForKey:@"eventId"];
        self.eventCount = [decoder decodeIntegerForKey:@"eventCount"];
        self.attributes = [decoder decodeObjectForKey:@"attributes"];
        self.attributeString = [decoder decodeObjectForKey:@"attributeString"];
        self.eventDate = [decoder decodeObjectForKey:@"eventDate"];
    }
    return self;
}

+ (instancetype)eventWithId:(NSString *)eventId attributes:(NSDictionary *)attributes
{
    EMCPageEvent *pageEvent = [[EMCPageEvent alloc] init];
    pageEvent.eventId    = eventId;
    pageEvent.attributes = attributes;
    pageEvent.eventCount = 1;
    pageEvent.eventDate = [NSDate date];
    return pageEvent;
}

+ (instancetype)eventWithId:(NSString *)eventId
{
    EMCPageEvent *pageEvent = [[EMCPageEvent alloc] init];
    pageEvent.eventId    = eventId;
    pageEvent.eventCount = 1;
    pageEvent.eventDate = [NSDate date];
    return pageEvent;
}

- (NSString *)attributeString
{
    if (!self.attributes || [[self.attributes allKeys] count] == 0) {
        return @"";
    }
    NSString *jsonString = [self.attributes jsonString];
    return jsonString;
    
//    NSMutableString *mstr = [[NSMutableString alloc] initWithString:@""];
//    NSArray *allKeys = self.attributes.allKeys;
//    
//    for (NSString *key in allKeys) {
//        BOOL isLast = ([allKeys lastObject] == key);
//        [mstr appendFormat:@"%@%@%@%@", key, @":", [self.attributes objectForKey:key], isLast ? @"" : @","];
//    }
//    
//    return mstr;
}

@end
