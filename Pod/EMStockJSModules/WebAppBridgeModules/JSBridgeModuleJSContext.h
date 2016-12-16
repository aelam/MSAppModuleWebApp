//
//  JSBridgeModuleJSContext.h
//  Pods
//
//  Created by ryan on 5/5/16.
//
//

// JSC方式仅在UIWebView的时候才有效, 后期使用WKWebView的时候会JSContext对应的方法会自动失效
// @canOpenURL JSC方式 最终会去掉
// @getAppInfo JSC方式 最终会去掉

#import "JSBridgeModule.h"

@interface JSBridgeModuleJSContext : JSBridgeModule

@end
