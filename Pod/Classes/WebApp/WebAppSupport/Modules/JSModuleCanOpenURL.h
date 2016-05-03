//
//  JSModuleCanOpenURL.h
//  Pods
//
//  Created by ryan on 4/28/16.
//
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface JSModuleCanOpenURL : NSObject

- (BOOL)canOpenURL:(NSString *)url callback:(JSValue *)callback;

@end
