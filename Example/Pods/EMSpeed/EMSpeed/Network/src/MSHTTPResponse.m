//
//  EMHTTPResponse.m
//  EMStock
//
//  Created by Ryan Wang on 4/13/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import "MSHTTPResponse.h"

@interface MSHTTPResponse() {
    
}
+ (NSDateFormatter *)updateTimeFormatter;
@end

@implementation MSHTTPResponse


+ (instancetype)responseWithObject:(id)object
{
    return [MSHTTPResponse responseWithDictionary:object];
}

+ (instancetype)responseWithDictionary:(NSDictionary *)responseObject
{
    return [[MSHTTPResponse alloc] initWithDictionary:responseObject];
}

- (id)initWithDictionary:(NSDictionary *)responseObject
{
    self = [super init];
    
    if (self) {
        self.originData = responseObject;
        
        if ([MSHTTPResponse isStandardResponse:responseObject]) {
            self.status = [responseObject[@"status"] integerValue];
            NSDateFormatter *formatter = [MSHTTPResponse updateTimeFormatter];
            self.updateTime = [formatter dateFromString:responseObject[@"updatetime"]];
            self.responseData = responseObject[@"data"];
            self.message = responseObject[@"message"];
        }
    }
    
    return self;
}

+ (instancetype)responseWithError:(NSError *)error
{
    MSHTTPResponse *response = [[MSHTTPResponse alloc] initWithDictionary:nil];
    response.error = error;
    return response;
}

+ (NSDateFormatter *)updateTimeFormatter
{
    static NSDateFormatter *_dateFormatter = nil;
    if (_dateFormatter == nil)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return _dateFormatter;
}

+ (BOOL)isStandardResponse:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSDictionary class]]
        && responseObject[@"status"]
        //        && responseObject[@"updatetime"]
        && responseObject[@"data"])
    {
        return YES;
    }
    
    return NO;
}

@end




