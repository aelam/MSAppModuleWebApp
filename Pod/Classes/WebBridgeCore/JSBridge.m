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

- (void)loadModules {
    [_modules removeAllObjects];
    
    NSMutableSet *moduleClasses = [NSMutableSet new];
    [moduleClasses addObjectsFromArray:JSGetModuleClasses()];
    
    for (Class c in moduleClasses) {
        id <JSBridgeModule> module = [c new];
        [self addJSModule:module];
    }
}

- (void)attachToBridge:(WebViewJavascriptBridge *)javascriptBridge {
    [_modules removeAllObjects];
    
    NSMutableSet *moduleClasses = [NSMutableSet new];
    [moduleClasses addObjectsFromArray:JSGetModuleClasses()];
    
    for (Class c in moduleClasses) {
        id <JSBridgeModule> module = [c new];
        [_modules addObject:module];
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
    NSDictionary *handlers = [module messageHandlers];
    for(NSString *key in [module messageHandlers]) {
        WVJBHandler handler = [handlers[key] copy];
        [self.javaScriptBridge registerHandler:key handler:handler];
    }
}

@end
