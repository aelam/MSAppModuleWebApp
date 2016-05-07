//
//  MSDataRequestModel.m
//  EMClickDemo
//
//  Created by flora on 15/9/16.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "MSDataRequestModel.h"
#import <EMSpeed/MSHTTP.h>
#import <EMSpeed/MSHTTPSessionManager.h>

@implementation MSDataRequestModel

- (NSURLSessionTask *)POST:(NSString *)URLString
                      data:(NSData *)data
                    fields:(NSDictionary *)headerFields
                     block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;
{
    return [self Method:@"POST" URLString:URLString data:data headerFields:headerFields block:block];
}


- (NSURLSessionTask *)Method:(NSString *)method
                   URLString:(NSString *)URLString
                        data:(NSData *)data
                headerFields:(NSDictionary *)headerFields
                       block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    if (headerFields && [headerFields allKeys]>0) {
        [mdict addEntriesFromDictionary:headerFields];
    }
    
    NSURLSessionTask *dataTask = [self method:method URLString:URLString data:data headerFields:mdict success:^(NSURLSessionTask *task, id responseObject) {
        if (block)
        {
            MSHTTPResponse *response = [MSHTTPResponse responseWithObject:responseObject];
            block(response, task, YES);
        }
    } failure:^(NSURLSessionTask *task, NSError *error) {
        if (block)
        {
            MSHTTPResponse *response = [MSHTTPResponse responseWithError:error];
            block(response, task, NO);
        }
    }];
    
    return dataTask;
}

- (NSURLSessionTask *)method:(NSString *)method
                   URLString:(NSString *)URLString
                        data:(NSData *)data
                headerFields:(NSDictionary *)headerFields
                     success:(void (^)(NSURLSessionTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionTask *task, NSError *error))failure
{
    NSError *serializationError = nil;
    
    MSHTTPSessionManager *manager = [MSHTTPSessionManager sharedManager];
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:URLString parameters:nil error:&serializationError];
    if (data) {
        request.HTTPBody = data;
    }
    for (NSString *key in [headerFields allKeys])
    {
        [request setValue:[headerFields objectForKey:key] forHTTPHeaderField:key];
    }
    
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(manager.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionTask *dataTask = nil;
    dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                [[NSNotificationCenter defaultCenter] postNotificationName:MSHTTPSessionManagerTaskDidFailedNotification object:dataTask];
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];
    
    [dataTask resume];
    return dataTask;
}
@end
