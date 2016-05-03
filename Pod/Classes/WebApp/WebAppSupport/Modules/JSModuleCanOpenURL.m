//
//  JSModuleCanOpenURL.m
//  Pods
//
//  Created by ryan on 4/28/16.
//
//

#import "JSModuleCanOpenURL.h"

@implementation JSModuleCanOpenURL

- (BOOL)canOpenURL:(NSString *)url callback:(JSValue *)callback {
    BOOL rs = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
    NSString* string = [NSString stringWithFormat:@"%@(%d);",callback,rs];

    NSMutableDictionary *info2 = [NSMutableDictionary dictionary];
    info2[@"canOpen"] = @(rs);
    [callback callWithArguments:callback];
    
    return rs;
}

@end
