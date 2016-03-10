//
//  NSURL+RoutableURL.m
//  Pods
//
//  Created by ryan on 3/10/16.
//
//

#import "NSURL+RoutableURL.h"
#import <EMSpeed/MSCore.h>

@implementation NSURL (RoutableURL)

+ (NSURL *)routableURLWithURL:(NSURL *)httpUrl {
    NSString *url = nil;
    if([httpUrl.host rangeOfString:@"emoney"].length > 0) {
        url = [httpUrl absoluteString];
    } else {
        url = [httpUrl absoluteString];
    }
    url = [url URLEncodedString];
    
    NSString *appUrl = [NSString stringWithFormat:@"web?url=%@",url];
    return [NSURL URLWithString:appUrl];
}



@end
