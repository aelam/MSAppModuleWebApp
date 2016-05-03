//
//  EMJSSouceCode.m
//  Pods
//
//  Created by ryan on 4/29/16.
//
//

#import "EMJSSouceCode.h"

@implementation EMJSSouceCode

+ (NSURL *)sourceCodeURL {
    NSURL *URL = [[NSBundle mainBundle] URLForResource:kJSBridgeFileName withExtension:nil];
    return URL;
}


@end
