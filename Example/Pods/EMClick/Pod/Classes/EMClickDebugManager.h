//
//  EMClickDebugManager.h
//  Pods
//
//  Created by Mac mini 2012 on 15/12/15.
//
//

#import <Foundation/Foundation.h>
#import "MSDataRequestModel.h"

#define kClickManagerDebugEnableKey @"kClickManagerDebugEnableKey"

@interface EMClickDebugManager : MSDataRequestModel
@property (nonatomic, assign) BOOL debugLogEnable; // debug log


- (NSURLSessionTask *)POSTUserInfo:(NSString *)URLString
                              data:(NSData *)data
                            fields:(NSDictionary *)headerFields
                             block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;

- (NSURLSessionTask *)POSTPagesAndEvents:(NSString *)URLString
                                    data:(NSData *)data
                                  fields:(NSDictionary *)headerFields
                               debugInfo:(NSDictionary *)debugInfo
                                   block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;
@end
