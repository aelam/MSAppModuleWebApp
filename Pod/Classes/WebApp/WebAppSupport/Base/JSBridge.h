//
//  JSBridgeManager.h
//  Pods
//
//  Created by ryan on 4/25/16.
//
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSDefines.h"

@protocol WebView <NSObject>

- (id<WebView>)webView;

@end


JS_EXTERN NSArray<Class> *JSGetModuleClasses(void);

@protocol JSBridgeModule;

@protocol JSBridge <JSExport>

//JSExportAs(call,
//- (JSValue *)call:(NSString *)method parameters:(NSDictionary *)parameters callback:(JSValue *)callback);

@end

@interface JSBridge : NSObject <JSBridge>

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) UIWebView *webView;
@property (nonatomic, weak) JSContext *context;

- (NSArray *)modules;
- (id<JSBridgeModule>)moduleForName:(NSString *)moduleName;
- (id<JSBridgeModule>)moduleForClass:(Class)moduleClass;

+ (instancetype)currentBridge;
+ (void)setCurrentBridge:(JSBridge *)bridge;
+ (instancetype)sharedBridge;

- (void)loadModules;

//- (JSValue *)call:(NSString *)method parameters:(NSDictionary *)parameters success:(JSBridgeSuccess)success error:(JSBridgeError)error;

@end
