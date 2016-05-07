//
//  NSDictionary+Query.h
//  EMSpeed
//
//  Created by Ryan Wang on 4/27/15.
//  Copyright (c) 2015 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Query)

- (NSString *)ms_query;

@end


@interface NSString  (URLAppendQueries)

- (NSString *)stringByAppendingParameters:(NSDictionary *)parameters;

@end