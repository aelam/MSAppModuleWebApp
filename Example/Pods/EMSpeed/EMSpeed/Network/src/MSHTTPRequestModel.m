//
//  EMHTTPRequestModel.m
//  EMSpeed
//
//  Created by Mac mini 2012 on 14-9-19.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import "MSHTTPRequestModel.h"
#import "MSHTTPResponse.h"
#import "MSHTTPSessionManager.h"

@implementation MSHTTPRequestModel

@synthesize tasks = _tasks;

- (void)dealloc
{
    [self cancelTasks];
}

- (void)cancelTasks
{
    for (NSURLSessionTask *task in _tasks) {
        [task cancel];
    }
    
    [_tasks removeAllObjects];
}

- (NSMutableArray *)getTasks
{
    if (_tasks == nil) {
        _tasks = [NSMutableArray array];
    }
    
    return _tasks;
}

- (NSURLSessionTask *)GET:(NSString *)URLString
                    param:(NSDictionary *)param
                    block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    return [self GET:URLString parameters:param headerFields:nil block:block];
}


- (NSURLSessionTask *)POST:(NSString *)URLString
                     param:(NSDictionary *)param
                     block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    return [self POST:URLString parameters:param headerFields:nil block:block];
}


- (NSURLSessionTask *)GET:(NSString *)URLString
               parameters:(NSDictionary *)param
             headerFields:(NSDictionary *)headers
                    block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    MSHTTPSessionManager *manager = [MSHTTPSessionManager sharedManager];
    
    NSMutableDictionary *newParameters = [param mutableCopy];
    if (self.defaultParameters) {
        [newParameters addEntriesFromDictionary:self.defaultParameters];
    }
    
    NSURLSessionTask *task = [manager GET:URLString parameters:newParameters headerFields:headers block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
        [self parseHTTPResponse:response URL:URLString];
        block(response, task, success);
        [self.tasks removeObject:task];
    }];
    
    if (task) {
        [self.tasks addObject:task];
    }
    
    return task;
}


- (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(NSDictionary *)param
              headerFields:(NSDictionary *)headers
                     block:(void (^)(MSHTTPResponse *, NSURLSessionTask *, BOOL))block
{
    MSHTTPSessionManager *manager = [MSHTTPSessionManager sharedManager];
    
    NSMutableDictionary *newParameters = [param mutableCopy];
    if (self.defaultParameters) {
        [newParameters addEntriesFromDictionary:self.defaultParameters];
    }
    
    NSURLSessionTask *task = [manager POST:URLString parameters:newParameters headerFields:headers block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
        [self parseHTTPResponse:response URL:URLString];
        block(response, task, success);
        [self.tasks removeObject:task];
    }];
    
    if (task) {
        [self.tasks addObject:task];
    }
    
    return task;
}

- (BOOL)parseHTTPResponse:(MSHTTPResponse *)response
                      URL:(NSString *)URLString{
    return YES;
}



@end