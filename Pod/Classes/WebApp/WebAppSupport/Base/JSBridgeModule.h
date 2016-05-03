//
//  JSModule.h
//  Pods
//
//  Created by ryan on 4/25/16.
//
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSDefines.h"

@class JSBridge;

@protocol JSBridgeModule <JSExport, NSObject>


#define JS_EXPORT_MODULE(js_name) \
JS_EXTERN void JSRegisterModule(Class); \
+ (NSString *)moduleName { return @#js_name; } \
+ (void)load { JSRegisterModule(self); }

+ (NSString *)moduleName;

- (NSString *)subscriptKey;
@property (nonnull, copy) id subscriptObject;


@optional

/**
 * A reference to the RCTBridge. Useful for modules that require access
 * to bridge features, such as sending events or making JS calls. This
 * will be set automatically by the bridge when it initializes the module.
 * To implement this in your module, just add `@synthesize bridge = _bridge;`
 */
@property (nonatomic, weak, readonly) JSBridge *bridge;


@end
