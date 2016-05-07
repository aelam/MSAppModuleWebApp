//
//  NSURL+URLTypes.m
//  Pods
//
//  Created by ryan on 2/23/16.
//
//

#import "NSURL+URLTypes.h"

@implementation NSURL (URLTypes)

- (BOOL)isAppleURL {
    return [[self host] rangeOfString:@"apple.com"].length > 0;
}

- (BOOL)isTelURL {
    return [[self scheme] isEqualToString:@"tel"];
}

- (BOOL)isTelPromptURL {
    return [[self scheme] isEqualToString:@"telprompt"];
}

- (BOOL)isMailURL {
    return [[self scheme] isEqualToString:@"mail"];
}

- (BOOL)isSMSURL {
    return [[self scheme] isEqualToString:@"sms"];
}

- (BOOL)isHTTP {
    return [[self scheme] isEqualToString:@"http"];
}

- (BOOL)isHTTPS {
    return [[self scheme] isEqualToString:@"https"];
}



@end
