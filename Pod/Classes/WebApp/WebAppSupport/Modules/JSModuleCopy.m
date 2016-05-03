//
//  JSModuleCopy.m
//  Pods
//
//  Created by ryan on 4/29/16.
//
//

#import "JSModuleCopy.h"
#import "JSDefines.h"
#import "JSBridge.h"

@implementation JSModuleCopy

JS_EXPORT_MODULE()

- (NSString *)subscriptKey {
    return @"copy";
}

- (id)subscriptObject {
    BOOL (^Copy)(NSString *, NSString *) = ^BOOL(NSString *urlString, NSString *callback) {
        BOOL rs = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]];
        NSString* string = [NSString stringWithFormat:@"%@(%d);",callback,rs];
        [self.bridge.context evaluateScript:string];
        
        return rs;
    };

    return Copy;
}

@end
