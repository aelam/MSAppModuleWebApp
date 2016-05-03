//
//  JSModuleShare.m
//  Pods
//
//  Created by ryan on 4/26/16.
//
//

#import "JSModuleShare.h"
#import "JSBridge.h"

@implementation JSModuleShare

JS_EXPORT_MODULE()

- (void)shareConfig:(NSDictionary *)parameters callback:(void (^)(NSDictionary *info))callback {
    
}


- (NSString *)methodName {
    return @"share";
}

- (JSValue *)callback {
    BOOL (^CanOpenURL)(NSString *, NSString *) = ^BOOL(NSString *urlString, NSString *callback) {
        BOOL rs = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]];
        NSString* string = [NSString stringWithFormat:@"%@(%d);",callback,rs];
        
        return rs;
    };

    
}

@end
