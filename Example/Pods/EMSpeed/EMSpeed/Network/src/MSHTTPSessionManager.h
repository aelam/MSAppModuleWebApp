//
//  MSHTTPSessionManager.h
//  EMSpeed
//
//  Created by Mac mini 2012 on 15/6/13.
//
//

#import "AFHTTPSessionManager.h"
#import "MSHTTPResponse.h"

@class MSHTTPResponse;


extern NSString * const MSHTTPSessionManagerTaskDidFailedNotification;


@protocol MSHTTPErrorHandler <NSObject>

- (void)handleRequestError:(NSError *)error;

- (void)handleRequestFlowData:(NSString *)URL
                  downLoadLen:(NSUInteger)download
                    uploadLen:(NSUInteger)upload;
@end

@interface MSHTTPSessionManager : AFHTTPSessionManager

@property (nonatomic, strong) id <MSHTTPErrorHandler>errorHandler;


+ (MSHTTPSessionManager *)sharedManager;

@property (nonatomic, strong) NSDictionary *defaultHeaders;   // 附加授权信息
@property (nonatomic, strong) NSDictionary *defaultParameters;// 附加授权信息


- (NSURLSessionTask *)GET:(NSString *)URLString
                    param:(NSDictionary *)param
                    block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block __deprecated;

- (NSURLSessionTask *)POST:(NSString *)URLString
                     param:(NSDictionary *)param
                     block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block __deprecated;

- (NSURLSessionTask *)GET:(NSString *)URLString
                parameters:(NSDictionary *)param
              headerFields:(NSDictionary *)headers
                     block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;


- (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(NSDictionary *)param
              headerFields:(NSDictionary *)headers
                     block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;


- (NSURLSessionTask *)method:(NSString *)method
                   URLString:(NSString *)URLString
                  parameters:(NSDictionary *)parameters
                headerFields:(NSDictionary *)headerFields
                     success:(void (^)(NSURLSessionTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionTask *task, NSError *error))failure;


@end
