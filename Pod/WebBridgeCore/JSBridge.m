//
//  JSBridgeManager.m
//  Pods
//
//  Created by ryan on 4/25/16.
//
//

#import "JSBridge.h"
#import "JSBridgeModule.h"

static NSMutableArray<Class> *JSModuleClasses;
NSArray<Class> *JSGetModuleClasses(void);
NSArray<Class> *JSGetModuleClasses(void)
{
    return JSModuleClasses;
}

/**
 * Register the given class as a bridge module. All modules must be registered
 * prior to the first bridge initialization.
 */
void JSRegisterModule(Class);
void JSRegisterModule(Class moduleClass)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        JSModuleClasses = [NSMutableArray new];
    });
    
    if (![moduleClass conformsToProtocol:@protocol(JSBridgeModule)]) {
        NSLog(@"%@ does not conform to the JSBridgeModule protocol",
              moduleClass);
    }
    
    // Register module
    [JSModuleClasses addObject:moduleClass];
}


@interface JSBridge ()

@property (nonatomic, strong) NSMutableArray *modules;

@end

@implementation JSBridge

static JSBridge *JSCurrentBridgeInstance = nil;

+ (instancetype)currentBridge {
    return JSCurrentBridgeInstance;
}

+ (void)setCurrentBridge:(JSBridge *)bridge {
    JSCurrentBridgeInstance = bridge;
}

+ (instancetype)sharedBridge {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        JSCurrentBridgeInstance = [[JSBridge alloc] init];
    });
    return JSCurrentBridgeInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _modules = [NSMutableArray array];
    }
    return self;
}

- (void)addJSModule:(id<JSBridgeModule>)module {
    [_modules addObject:module];
    [self setBridgeForInstance:module];
}

- (void)removeJSModule:(id<JSBridgeModule>)module {
    [_modules removeObject:module];
}

- (id<JSBridgeModule>)moduleForName:(NSString *)moduleName {
    return [self moduleForClass:NSClassFromString(moduleName)];
}

- (id<JSBridgeModule>)moduleForClass:(Class)moduleClass {
    for(NSObject <JSBridgeModule>*module in self.modules) {
        if([module isMemberOfClass:moduleClass]) {
            return module;
        }
    }
    return nil;
}

- (void)attachToBridge:(id <WebViewJavascriptBridgeProtocol>)javascriptBridge {
    [_modules removeAllObjects];
    
    NSMutableSet *moduleClasses = [NSMutableSet new];
    [moduleClasses addObjectsFromArray:JSGetModuleClasses()];

    for (Class c in moduleClasses) {
        id <JSBridgeModule> module = [c new];
        [_modules addObject:module];
    }
    
    // sort
    [_modules sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        id <JSBridgeModule> module1 = obj1;
        id <JSBridgeModule> module2 = obj2;
        
        if([module1 priority] > [module2 priority]) {
            return NSOrderedAscending;
        } else if([module1 priority] == [module2 priority]) {
            return NSOrderedSame;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    // load
    for(id <JSBridgeModule> module in _modules) {
        //TODO 更好的方式?
        [self setBridgeForInstance:module];
        [module attachToJSBridge:self];
        
        [self registerHandlersWithModule:module];
    }
}


- (void)setBridgeForInstance:(NSObject<JSBridgeModule> *)module
{
    if ([module respondsToSelector:@selector(bridge)] && module.bridge != self) {
        @try {
            [(id)module setValue:self forKey:@"bridge"];
        }
        @catch (NSException *exception) {
            NSLog(@"%@", exception);
        }
    }
}

- (void)registerHandlersWithModule:(id<JSBridgeModule>)module {
    if(self.webView) {
        if ([module respondsToSelector:@selector(moduleSourceFile)]) {
            NSString *moduleSourceFile = [module moduleSourceFile];
            if (moduleSourceFile) {
                NSString *source = [[NSString alloc] initWithContentsOfFile:moduleSourceFile encoding:NSUTF8StringEncoding error:NULL];
                if ([self.webView isKindOfClass:[WKWebView class]]) {
                    WKWebView *wkWebView = (WKWebView *)self.webView;
                    WKUserContentController *userContentController = wkWebView.configuration.userContentController;
                    WKUserScript *script = [[WKUserScript alloc] initWithSource:source injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
                    [userContentController addUserScript:script];
                } else {
                    [self.webView x_evaluateJavaScript:source];
                }
            }
        }
        
        NSDictionary *handlers = [module messageHandlers];
        for(NSString *key in handlers) {
            WVJBHandler handler = [handlers[key] copy];
            [self.javaScriptBridge registerHandler:key handler:handler];
        }
        
        UIWebView *webView  = (UIWebView *)self.webView;
        if ([webView isKindOfClass:[UIWebView class]]) {
            NSDictionary *JSContextHandlers = [module JSContextMessageHandlers];
            for(NSString *key in JSContextHandlers) {
                id handler = [JSContextHandlers[key] copy];
                [self.javascriptContext setObject:key forKeyedSubscript:handler];
            }
            
        }
    }
}

- (void)reset {
    self.viewController = nil;
    self.webView = nil;
    self.javaScriptBridge = nil;
    self.javascriptContext = nil;
}

@end
