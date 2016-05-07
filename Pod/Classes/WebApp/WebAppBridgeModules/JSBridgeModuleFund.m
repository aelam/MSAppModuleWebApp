//
//  JSBridgeModuleFund.m
//  Pods
//
//  Created by ryan on 5/3/16.
//
//

#import "JSBridgeModuleFund.h"

@implementation JSBridgeModuleFund

JS_EXPORT_MODULE();

- (NSString *)moduleSourceFile {
    return nil;
    return [[NSBundle bundleForClass:self] pathForResource:@"EMJSBridgeFund" ofType:@"js"];
}

- (void)attachToJSBridge:(JSBridge *)bridge {
}


- (void)registerGetAppInfoWithBridge:(JSBridge *)bridge {
}

@end
