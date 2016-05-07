//
//  MSThemeKitManager.m
//  Pods
//
//  Created by Mac mini 2012 on 15/10/22.
//
//

#import "MSThemeManager.h"
#import "UIColor+HexString.h"

NSString * const MSThemeManagerThemeKey       = @"MSThemeKit";
NSString * const MSThemeManagerCommonModule   = @"common";
NSString * const MSThemeManagerDidChangeTheme = @"MSThemeManagerDidChangeTheme";

NSString * const MSThemeErrorDomain            = @"com.emoney.mstheme";

@interface MSThemeManager() {
    
    BOOL _isRegistered;
    NSString *_tempThemeName;
    NSString *_currentThemeName;
    NSMutableArray *_themes;
    NSMutableArray *_modules;
    
    NSDictionary *_style;  // 某种场景的颜色,字体风格

    NSMutableDictionary *_tempStyles; // 临时主题色
}

+ (instancetype)sharedManager;

@end


@implementation MSThemeManager


+ (instancetype)sharedManager {
    
    static dispatch_once_t onceQueue;
    static MSThemeManager *__sharedTheme = nil;
    
    dispatch_once(&onceQueue, ^{
        __sharedTheme = [[self alloc] init];
    });
    
    return __sharedTheme;
}


# pragma mark - Init

- (instancetype)init {
    
    if (self = [super init]) {
        _tempStyles = [NSMutableDictionary dictionary];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    
    return self;
}


// 内存警告处理, 还是保留当前主题色style, 其他都删除了
- (void)didReceiveMemoryWarning
{
    NSDictionary *style = nil;
    
    if ([_currentThemeName length] > 0) {
        style = [_tempStyles objectForKey:_currentThemeName];
        [_tempStyles removeAllObjects];
        if (style) {
            [_tempStyles setObject:style forKey:_currentThemeName];
        }
    }
    else {
        [_tempStyles removeAllObjects];
    }
}


+ (NSString *)currentTheme
{
    return [[self sharedManager] currentTheme];
}


- (NSString *)currentTheme
{
    return _currentThemeName;
}


+ (NSString *)tempTheme
{
    return [[self sharedManager] tempTheme];
}


- (NSString *)tempTheme
{
    return _tempThemeName;
}


# pragma mark - Register

+ (BOOL)registerThemes:(NSArray *)themes modules:(NSArray *)modules
{
    // 注册场景
    if (![[self sharedManager] registerThemes:themes]) {
        NSLog(@"注册主题色场景失败!");
        return NO;
    }
    
    // 注册模块
    if (![[self sharedManager] registerModules:modules]) {
        NSLog(@"注册主题色模块失败!");
        return NO;
    }
    
    // 修改场景
    NSString *defaultTheme = [[self sharedManager] defaultThemeName];
    NSError *error = nil;
    if (![[self sharedManager] changeTheme:defaultTheme error:&error]) {
        NSLog(@"修改主题色场景失败! %@", [error localizedDescription]);
        return NO;
    }
    
    [[self sharedManager] setRegisted:YES];
    
    return YES;
}


// 从userdefault中读取之前保存的主题名称, 否则读取themes数组中的第一个
- (NSString *)defaultThemeName
{
    NSString *result = nil;
    
    // 从userdefault中读取之前保存的主题名称
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *themeName = [defaults objectForKey:[MSThemeManager themeKeyForUserDefault]];
    if ([themeName length] > 0) {
        // 判断下default是否在_themes中
        if ([self themesContainsTheme:themeName]) {
            result = themeName;
        }
    }
    
    // 读取themes数组中的第一个
    if (!result && [_themes count] > 0) {
        result = [_themes objectAtIndex:0];
    }
    
    return result;
}


- (BOOL)registerThemes:(NSArray *)themes
{
    if ([themes count] <= 0) {
        return NO;
    }
    
    _themes = [NSMutableArray arrayWithArray:themes];

    return YES;
}


- (BOOL)registerModules:(NSArray *)modules
{
    if ([modules count] == 0) {
        _modules = [NSMutableArray array];
    }
    else {
        _modules = [NSMutableArray arrayWithArray:modules];
    }
    
    return YES;
}

- (NSDictionary *)reloadStyleWithTheme:(NSString *)themeName
{
    // 创建新的style
    NSDictionary *style = [NSMutableDictionary dictionary];
    
    // 加载通用的style
    NSDictionary *dict = [self loadTheme:themeName
                                  module:MSThemeManagerCommonModule];
    style = [self mergeDictionary1:style dictionary2:dict];
    
    // 加载模块的style
    for (NSString *module in _modules) {
        NSDictionary *dict = [self loadTheme:themeName
                                      module:module];
        style = [self mergeDictionary1:style dictionary2:dict];
    }
    
    return style;
}

- (void)setRegisted:(BOOL)reg
{
    _isRegistered = reg;
    NSLog(@"注册主题色成功!\n主题色%@\n模块%@\n当前主题[%@]!", _themes, _modules, _currentThemeName);
}

# pragma mark - Change Theme

+ (void)changeTheme:(NSString *)themeName
{
    NSError *error = nil;
    
    if ([[self sharedManager] changeTheme:themeName error:&error]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MSThemeManagerDidChangeTheme object:nil];
        
        NSLog(@"切换主题色[%@]!", themeName);
        return;
    }
    else {
        NSLog(@"切换主题色[%@]失败!", themeName);
    }
}


- (BOOL)changeTheme:(NSString *)themeName error:(NSError **)error {
    
    if ([themeName length]==0) {
        *error = [NSError errorWithDomain:MSThemeErrorDomain code:100 userInfo:@{@"localizedDescription" : @"theme name = nil"}];
        return NO;
    }
    
    if ([_currentThemeName length]>0
        && [themeName isEqualToString:_currentThemeName]
        && _style!=nil) {
        
        *error = [NSError errorWithDomain:MSThemeErrorDomain code:100 userInfo:@{@"localizedDescription" : [NSString stringWithFormat:@"当前已经是 %@",themeName]}];
        return NO;
    }
    
    if (![self themesContainsTheme:themeName]) {
        
        *error = [NSError errorWithDomain:MSThemeErrorDomain code:100 userInfo:@{@"localizedDescription" : [NSString stringWithFormat:@"该主题色没有被注册 %@",themeName]}];
        
        return NO;
    }
    
    _currentThemeName = themeName;
    
    _style = [self reloadStyleWithTheme:_currentThemeName];
    [_tempStyles setObject:_style forKey:_currentThemeName];
    
    // 保存
    [[NSUserDefaults standardUserDefaults] setObject:_currentThemeName
                                              forKey:[MSThemeManager themeKeyForUserDefault]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}


- (NSDictionary *)loadTheme:(NSString *)themeName
                     module:(NSString *)module
{
    NSString *filePath = [self modulePath:module theme:themeName];
    return [self loadThemeWithPath:filePath];
}

- (NSString *)modulePath:(NSString *)module
                   theme:(NSString *)themeName
{
    // remove ".plist"
    if ([module rangeOfString:@".plist"].location != NSNotFound) {
        module = [module stringByReplacingOccurrencesOfString:@".plist" withString:@""];
    }
    
    NSString *path = nil;
    
    // file path
    path = [NSString stringWithFormat:@"%@_%@.plist", module, themeName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return path;
    }
    
    // main bundle path
    path = [NSString stringWithFormat:@"%@_%@", module, themeName];
    path = [[NSBundle mainBundle] pathForResource:path ofType:@"plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return path;
    }
    
    return module;
}


- (NSDictionary *)loadThemeWithPath:(NSString *)path
{
    NSDictionary *styles = [NSDictionary dictionaryWithContentsOfFile:path];
    if (!styles) {
        NSLog(@"load theme failed! path[%@]", path);
    }
    
    return [self parseStyles:styles];
}


- (NSDictionary *)parseStyles:(NSDictionary *)styles
{
    [self checkDuplicateKeys:styles];
    
    return [self _parseKeysWithStyles:styles];
}


- (NSDictionary *)_parseKeysWithStyles:(NSDictionary *)styles
{
    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    
    for (NSString *key in styles) {
        id obj = [styles objectForKey:key];
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [mdict addEntriesFromDictionary:obj];
        }
        else if ([obj isKindOfClass:[NSString class]]) {
            [mdict setObject:obj forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:mdict];
}


# pragma mark - Use Temp Theme


+ (void)useTempTheme:(NSString *)theme
{
    [[self sharedManager] useTempTheme:theme];
}


- (BOOL)useTempTheme:(NSString *)theme
{
    if ([theme length] == 0) {
        return NO;
    }

    NSDictionary *style = [self cachedTempStyle:theme];

    if (style) {
        _tempThemeName = theme;
        _style = style;
        NSLog(@"临时切换主题色[%@]!", theme);
        
        return YES;
    }
    
    return NO;
}


- (NSDictionary *)cachedTempStyle:(NSString *)theme
{
    NSDictionary *style = [_tempStyles objectForKey:theme];
    
    if (!style) {
        style = [self reloadStyleWithTheme:theme];
    
        if (style) {
            [_tempStyles setObject:style forKey:theme];
        }
    }
    
    return style;
}


+ (void)restore
{
    [[self sharedManager] restore];
}


- (BOOL)restore
{
    if ([NSThread currentThread] != [NSThread mainThread]) {
        NSLog(@"please invoke this method[%s] in main thread!", __func__);
    }
    
    if ([_currentThemeName length] == 0) {
        NSLog(@"没有可以还原的主题色[%@]", _currentThemeName);
        return NO;
    }
    
    NSDictionary *style = [self cachedTempStyle:_currentThemeName];
    if (!style) {
        style = [self reloadStyleWithTheme:_currentThemeName];
    }
    
    if (style) {
        _style = style;
        _tempThemeName = nil;
        NSLog(@"还原主题色[%@]", _currentThemeName);
        return YES;
    }
    
    return NO;
}



# pragma mark - Color

+ (UIColor *)colorForKey:(NSString *)key
{
    return [[self sharedManager] colorForKey:key];
}

- (UIColor *)colorForKey:(NSString *)key
{
    UIColor *color = [self _colorForKey:key];
    
    if (!color) {
        NSArray *coms = [key componentsSeparatedByString:@"_"];
        if ([coms count] > 1) {
            NSString *aKey = [coms objectAtIndex:1];
            color = [self _colorForKey:aKey];
        }
    }
    
    if (!color) {
        NSLog(@"主题[%@] 颜色[%@] 没有找到", _currentThemeName, key);
    }
    
    return color;
}


- (UIColor *)colorForKey:(NSString *)key module:(NSString *)module
{
    key = [NSString stringWithFormat:@"%@_%@.png", module, key];
    return [self _colorForKey:key];
}

- (UIColor *)_colorForKey:(NSString *)key
{
    NSString *hexString = _style[key];
    
    while (_style[hexString]) {
        hexString = _style[hexString];
    }
    
    if (hexString) {
        return [UIColor colorWithHexString:hexString];
    }
    
    return nil;
}


# pragma mark - Font

+ (UIFont *)fontForKey:(NSString *)key
{
    return [[self sharedManager] fontForKey:key];
}


- (UIFont *)fontForKey:(NSString *)key
{
    NSString *sizeKey = [key stringByAppendingString:@"Size"];
    
    NSString *fontName = _style[key];
    NSString *size = _style[sizeKey];
    
    while (_style[fontName]) {
        fontName = _style[fontName];
    }
    
    while (_style[size]) {
        size = _style[size];
    }
    
    if (fontName && size) {
        if ([fontName isEqualToString:@"bold"])
        {
            return [UIFont boldSystemFontOfSize:size.floatValue];
        }
        else
        {
            return [UIFont fontWithName:fontName size:size.floatValue];
        }
    }
    else if (size)
    {
        return [UIFont systemFontOfSize:size.floatValue];
    }
    
    return nil;
}



# pragma mark - Image

+ (UIImage *)imageForKey:(NSString *)key
{
    return [[self sharedManager] imageForKey:key];
}


- (UIImage *)imageForKey:(NSString *)key
{
    NSString *imageName = _style[key];
    
    while (_style[imageName]) {
        imageName = _style[imageName];
    }
    
    if (imageName) {
        return [UIImage imageNamed:imageName];
    }
    
    return nil;
}



# pragma mark - Utils

- (BOOL)themesContainsTheme:(NSString *)aTheme
{
    for (NSString *theme in _themes) {
        if ([theme isEqualToString:aTheme]) {
            return YES;
        }
    }
    
    return NO;
}


+ (NSString *)themeKeyForUserDefault
{
    return [MSThemeManager bundleIdentifier:MSThemeManagerThemeKey];
}

+ (NSString *)bundleIdentifier:(NSString *)name
{
    static NSString *idString = nil;
    
    if (idString == nil)
    {
        CFStringRef identifier = CFBundleGetIdentifier(CFBundleGetMainBundle());
        idString = (__bridge NSString *)identifier;
        idString = [[NSString alloc] initWithFormat:@"%@.%@",idString,name];
    }
    return idString;
}


- (BOOL)checkDuplicateKeys:(NSDictionary *)styles
{
    BOOL verify = YES;
    
    NSMutableDictionary *dictKeys = [NSMutableDictionary dictionary];
    NSMutableArray *conflictKeys = [NSMutableArray array];
    
    // 计算重复的key
    for (NSString *key in styles) {
        id obj = [styles objectForKey:key];
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            for (NSString *akey in obj) {
                if ([dictKeys objectForKey:akey]) {
                    [conflictKeys addObject:akey];
                }
                
                [dictKeys setObject:obj forKey:akey];
            }
        }
        else if ([obj isKindOfClass:[NSString class]]) {
            if ([dictKeys objectForKey:key]) {
                [conflictKeys addObject:key];
            }
            [dictKeys setObject:obj forKey:key];
        }
    }
    
    if ([conflictKeys count]>0) {
        NSLog(@"重复的key = %@", conflictKeys);
        verify = NO;
    }
    
    return verify;
}


- (NSDictionary *)mergeDictionary1:(NSDictionary *)dict1
                       dictionary2:(NSDictionary *)dict2
{
    NSMutableDictionary *tmp = [NSMutableDictionary dictionaryWithDictionary:dict1];
    
    [dict2 enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if ([tmp objectForKey:key]) {
            NSLog(@"重复的key = %@", key);
        }
        tmp[key] = obj;
    }];
    
    return tmp;
}

# pragma mark - For Test


+ (NSString *)colorKeyForKey:(NSString *)key
{
    return [[MSThemeManager sharedManager] colorKeyForKey:key];
}

- (NSString *)colorKeyForKey:(NSString *)key
{
    NSString *result = [self _colorKeyForKey:key];
    
    if (!result || [result length]<=0) {
        NSArray *coms = [key componentsSeparatedByString:@"_"];
        if ([coms count] > 1) {
            NSString *aKey = [coms objectAtIndex:1];
            result = [self _colorKeyForKey:aKey];
        }
    }
    
    return result;
}

- (NSString *)_colorKeyForKey:(NSString *)key
{
    NSString *result = key;
    NSString *hexString = _style[key];
    
    while (_style[hexString]) {
        result = hexString;
        hexString = _style[hexString];
    }
    
    if (hexString) {
        return result;
    }
    
    return @"";
}

+ (NSString *)colorHexForKey:(NSString *)key
{
    return [[self sharedManager] colorHexForKey:key];

}

- (NSString *)colorHexForKey:(NSString *)key
{
    NSString *result = [self _colorHexForKey:key];
    
    if (!result || [result length]<=0) {
        NSArray *coms = [key componentsSeparatedByString:@"_"];
        if ([coms count] > 1) {
            NSString *aKey = [coms objectAtIndex:1];
            result = [self _colorHexForKey:aKey];
        }
    }
    
    return result;
}

- (NSString *)_colorHexForKey:(NSString *)key
{
    NSString *hexString = _style[key];
    
    while (_style[hexString]) {
        hexString = _style[hexString];
    }
    
    if ([hexString length]>0) {
        return hexString;
    }
    
    return @"";
}

@end
