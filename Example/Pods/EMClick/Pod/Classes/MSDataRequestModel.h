//
//  MSDataRequestModel.h
//  EMClickDemo
//
//  Created by flora on 15/9/16.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MSHTTPRequestModel.h"

@interface MSDataRequestModel : MSHTTPRequestModel

- (NSURLSessionTask *)POST:(NSString *)URLString
                      data:(NSData *)data
                    fields:(NSDictionary *)headerFields
                     block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;
@end
