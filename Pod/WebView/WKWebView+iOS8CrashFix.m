//
//  WKWebView+iOS8CrashFix.m
//  MSAppModuleWebApp
//
//  Created by ryan on 23/10/2017.
//

/*
作者：hope7th
链接：http://www.jianshu.com/p/bb20ff351fa2
來源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
*/

#import "WKWebView+iOS8CrashFix.h"
#import <JRSwizzle/JRSwizzle.h>
#import <UIKit/UIKit.h>

@implementation WKWebView (iOS8CrashFix)

+ (void)load {
    float systemVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (systemVersion >= 8.0 && systemVersion < 9.0) {
        [self jr_swizzleMethod:NSSelectorFromString(@"evaluateJavaScript:completionHandler:") withMethod:@selector(altEvaluateJavaScript:completionHandler:) error:nil];
    }
}

/*
 * fix: WKWebView crashes on deallocation if it has pending JavaScript evaluation
 */
- (void)altEvaluateJavaScript:(NSString *)javaScriptString completionHandler:(void(^)(id, NSError *))completionHandler {
    id strongSelf = self;
    [self altEvaluateJavaScript:javaScriptString completionHandler:^(id r, NSError *e) {
        [strongSelf title];
        if(completionHandler) {
            completionHandler(r, e);
        }
    }];
}

@end
