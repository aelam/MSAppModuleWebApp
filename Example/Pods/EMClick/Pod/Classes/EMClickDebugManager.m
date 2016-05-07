//
//  EMClickDebugManager.m
//  Pods
//
//  Created by Mac mini 2012 on 15/12/15.
//
//

#import "EMClickDebugManager.h"
#import "EMClickManager.h"
#import "EMClickUploadCache.h"
#import "EMClickDebugLog.h"
#import "MSHTTPResponse.h"
//#import <CRToast/CRToast.h>



@implementation EMClickDebugManager

- (void)setDebugLogEnable:(BOOL)debugLogEnable
{
    [EMClickDebugLogManager enable:debugLogEnable];
}

- (BOOL)debugLogEnable
{
    return [EMClickDebugLogManager isEnable];
}

- (NSURLSessionTask *)POSTUserInfo:(NSString *)URLString
                              data:(NSData *)data
                            fields:(NSDictionary *)headerFields
                             block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    NSURLSessionTask *task = [self POST:URLString
                                   data:data
                                 fields:headerFields
                                  block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
                                      if (success
                                          && response.status == MSHTTPResponseStatusOK)
                                      {
                                          [self endUserLogWithTaskIdentifier:task.taskIdentifier successful:success error:task.error];
                                      }
                                      if (block) {
                                          block(response, task, success);
                                      }
                                  }];
    
    [self beginUserLogWithTaskIdentifier:task.taskIdentifier url:URLString];
    
    if ([task respondsToSelector:@selector(priority)]) {
        task.priority = NSURLSessionTaskPriorityLow;
    }
    
    return task;
}

- (EMClickDebugLog *)beginUserLogWithTaskIdentifier:(unsigned long)identifier url:(NSString *)url
{
    return [self beginLogWithTaskIdentifier:identifier typeName:@"userData" url:url];
}

- (void)endUserLogWithTaskIdentifier:(unsigned long)identifier
                          successful:(BOOL)successful
                               error:(NSError *)error
{
    [self endLogWithTaskIdentifier:identifier typeName:@"userData" successful:successful error:error];
}


- (NSURLSessionTask *)POSTPagesAndEvents:(NSString *)url
                                    data:(NSData *)data
                                  fields:(NSDictionary *)headerFields
                               debugInfo:(NSDictionary *)debugInfo
                                   block:(void (^)(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    __weak EMClickDebugManager *weakSelf = self;
    
    NSURLSessionTask *task = [self POST:url
                                   data:data
                                 fields:headerFields
                                  block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
                                      BOOL isSubmitSuccessful = success && response.status == MSHTTPResponseStatusOK;                                      [weakSelf endPageLogWithTaskIdentifier:task.taskIdentifier
                                                                                                                                                                                       successful:isSubmitSuccessful
                                                                                                                                                                                            error:task.error];
                                      if (block) {
                                          block(response, task, success);
                                      }
                                  }];
    
    [self beginPageLogWithTaskIdentifier:task.taskIdentifier url:url json:[debugInfo objectForKey:@"json"] pages:[[debugInfo objectForKey:@"pages"] intValue] events:[[debugInfo objectForKey:@"events"] intValue]];
    
    if ([task respondsToSelector:@selector(priority)]) {
        task.priority = NSURLSessionTaskPriorityLow;
    }
    
    return task;
}


- (EMClickDebugLog *)beginPageLogWithTaskIdentifier:(unsigned long)identifier
                                                url:(NSString *)url
                                               json:(NSDictionary *)json
                                              pages:(int)numberOfPages
                                             events:(int)numberOfEvents
{
    EMClickDebugLog *log = [self beginLogWithTaskIdentifier:identifier typeName:@"pageData" url:url];
    log.numberOfPages = numberOfPages;
    log.numberOfEvents = numberOfEvents;
    log.server = url;
    log.date = [NSDate date];
    log.json = json;
    
    return log;
}



- (void)endLogWithTaskIdentifier:(unsigned long)identifier
                        typeName:(NSString *)typeName
                      successful:(BOOL)successful
                           error:(NSError *)error
{
    if ([EMClickDebugLogManager isEnable]) {
        NSString *key = [NSString stringWithFormat:@"%@_%lu", typeName, identifier];
        EMClickDebugLog *log = [EMClickDebugLogManager logWithIdentifier:key];
        log.successful = successful;
        log.error = error;
        
        if ([log saveToLocal]) {
            [EMClickDebugLogManager removeLogWithIdentifier:key];
        }
    }
}

- (EMClickDebugLog *)beginLogWithTaskIdentifier:(unsigned long)identifier
                                       typeName:(NSString *)typeName
                                            url:(NSString *)url
{
    if ([EMClickDebugLogManager isEnable]) {
        EMClickDebugLog *log = [[EMClickDebugLog alloc] init];
        log.server = url;
        log.updateTypeName = typeName;
        [EMClickDebugLogManager setLog:log withIdentifier:[NSString stringWithFormat:@"%@_%lu", typeName, identifier]];
        log.date = [NSDate date];
        
        return log;
    }
    
    return nil;
}

- (void)endPageLogWithTaskIdentifier:(unsigned long)identifier
                          successful:(BOOL)successful
                               error:(NSError *)error
{
    [self endLogWithTaskIdentifier:identifier typeName:@"pageData" successful:successful error:error];
}




//- (void)showBeginPageLog:(NSString *)event attributes:(NSDictionary *)attributes {
//    [CRToastManager showNotificationWithMessage:[NSString stringWithFormat:@"beginPage: %@",event] completionBlock:^{
//    }];
//}
//
//- (void)showEndPageLog:(NSString *)event attributes:(NSDictionary *)attributes {
//    [CRToastManager showNotificationWithMessage:[NSString stringWithFormat:@"endPage: %@",event] completionBlock:^{
//    }];
//}
//
//
//- (void)showEventLog:(NSString *)event attributes:(NSDictionary *)attributes {
//    [CRToastManager showNotificationWithOptions:
//     @{kCRToastBackgroundColorKey: [UIColor lightGrayColor],
//       kCRToastTextKey : event}
//                                 apperanceBlock:nil
//                                completionBlock:^{}];
//}

@end