//
//  EMSpeedWebModel.h
//  EMSpeed
//
//  Created by Mac mini 2012 on 14-9-19.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class MSHTTPResponse;

@protocol MSHTTPRequestModel <NSObject>

- (void)cancelTasks;

@end

/**
 *  HTTP请求的Model, 具有收发包功能,
 */
@interface MSHTTPRequestModel : NSObject <MSHTTPRequestModel>{
    NSMutableArray *_tasks;
}

@property (nonatomic, strong, getter=getTasks) NSMutableArray *tasks;
@property (nonatomic, strong) NSDictionary *defaultParameters;

- (NSURLSessionTask *)GET:(NSString *)URLString
                    param:(NSDictionary *)param
                    block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;

- (NSURLSessionTask *)POST:(NSString *)URLString
                     param:(NSDictionary *)param
                     block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;


- (NSURLSessionTask *)GET:(NSString *)URLString
               parameters:(NSDictionary *)param
             headerFields:(NSDictionary *)headers
                    block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;

- (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(NSDictionary *)param
              headerFields:(NSDictionary *)headers
                     block:(void (^)(MSHTTPResponse *, NSURLSessionTask *, BOOL))block;

/**
 *  解析HTTP请求返回的对象, 如果是标准格式下, 子类只需要实现这个方法就可以了, 所有数据已保存在EMHTTResponse的responseData或originData中
 *
 *  @param response  经过解析的EMHTTResponse对象
 *  @param URLString HTTP请求的URL
 *
 *  @return 是否解析成功
 */
- (BOOL)parseHTTPResponse:(MSHTTPResponse *)response
                      URL:(NSString *)URLString;

/**
 *  取消请求任务
 */
- (void)cancelTasks;

@end
