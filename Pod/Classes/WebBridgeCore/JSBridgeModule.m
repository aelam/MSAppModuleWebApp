//
//  JSBridgeModule.m
//  Pods
//
//  Created by ryan on 5/3/16.
//
//

#import "JSBridgeModule.h"

NSString * const JSResponseErrorCodeKey    = @"status";
NSString * const JSResponseErrorMessageKey = @"message";
NSString * const JSResponseErrorDataKey    = @"data";


@interface JSBridgeModule ()

@property (nonatomic, strong) NSMutableDictionary *messageHandlers;
@property (nonatomic, strong) NSMutableDictionary *JSContextMessageHandlers;

@end

@implementation JSBridgeModule

+ (NSString *)moduleName {
    return NSStringFromClass(self);
}

+ (NSString *)moduleSourceFile {
    return nil;
}

- (NSUInteger)priority {
    return JSBridgeModulePriorityNormal;
}

- (NSString *)moduleSourceFile {
    return nil;
}

- (instancetype)init {
    if (self = [super init]) {
        _messageHandlers = [NSMutableDictionary dictionary];
        _JSContextMessageHandlers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)handler {
    _messageHandlers[handlerName] = [handler copy];
}

- (NSDictionary *)messageHandlers {
    return _messageHandlers;
}

- (void)attachToJSBridge:(JSBridge *)bridge {
    
}

- (void)registerHandler:(NSString *)handlerName JSContextHandler:(JSValue *)handler {
    _JSContextMessageHandlers[handlerName] = [handler copy];

}

- (NSDictionary *)JSContextMessageHandlers {
    return _JSContextMessageHandlers;
}



@end
