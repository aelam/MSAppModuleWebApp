//
//  JSBridgeModuleCommunityPost.m
//  Pods
//
//  Created by ryan on 5/6/16.
//
//

#import "JSBridgeModuleCommunityPost.h"

@implementation JSBridgeModuleCommunityPost

JS_EXPORT_MODULE();

- (NSString *)moduleSourceFile {
    return nil;
    return [[NSBundle bundleForClass:self] pathForResource:@"EMJSBridgeCommunityPost" ofType:@"js"];
}

- (void)attachToJSBridge:(JSBridge *)bridge {
    
}


- (void)registerPostWithBridge:(JSBridge *)bridge {
    
}



@end
