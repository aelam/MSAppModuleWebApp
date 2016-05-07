//
//  EMClickLog.m
//  Pods
//
//  Created by Mac mini 2012 on 15/11/20.
//
//

#import "EMClickDebugLog.h"

@implementation EMClickDebugLog

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        self.server = nil;
        self.successful = NO;
    }
    
    return self;
}

- (void)setNumberOfEvents:(int)numberOfEvents{
    _numberOfEvents = numberOfEvents;
}

-(void)setNumberOfPages:(int)numberOfPages{
    _numberOfPages = numberOfPages;
}

- (NSString *)textString
{
    NSMutableString *mstr = [NSMutableString string];
    [mstr appendFormat:@"type : %@ \n", self.updateTypeName];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:self.date];
    
    [mstr appendFormat:@"date : %@ \n", strDate];
    [mstr appendFormat:@"server : %@ \n", self.server];
    [mstr appendFormat:@"successful : %d \n", self.successful];
    [mstr appendFormat:@"pages : %d \n", self.numberOfPages];
    [mstr appendFormat:@"events : %d \n", self.numberOfEvents];
    
    if (self.error) {
        [mstr appendFormat:@"error : %@", [self.error localizedDescription]];
    }
    
    if (self.json) {
        [mstr appendFormat:@"\n%@\n\n", self.json];
    }
    
    return mstr;
}

- (BOOL)saveToLocal
{
    NSUUID *uuid = [NSUUID UUID];
    NSString *filePath = [self pathForDocsResource:uuid.UUIDString];
    
    NSString *logString = [self textString];
    
    NSError *error = nil;
    BOOL flag = [logString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"save click debug log failed! %@", [error localizedDescription]);
    }
    
    return flag;
}

- (NSString *)pathForDocsResource:(NSString *)relativePath {
    static NSString* cachesPath = nil;
    if (nil == cachesPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask,
                                                            YES);
        cachesPath = [dirs objectAtIndex:0];
    }
    return [cachesPath stringByAppendingPathComponent:relativePath];
}

@end



@interface EMClickDebugLogManager()

@property (nonatomic, strong) NSMutableDictionary *cachedLogs;
@property (nonatomic, assign) BOOL enable;
@end



@implementation EMClickDebugLogManager

+ (EMClickDebugLogManager *)sharedManager
{
    static EMClickDebugLogManager *__instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[EMClickDebugLogManager alloc] init];
    });
    
    return __instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cachedLogs = [NSMutableDictionary dictionary];
        _enable = [[NSUserDefaults standardUserDefaults] boolForKey:kClickManagerLogEnableKey];
    }
    
    return self;
}

+ (BOOL)isEnable
{
    return [EMClickDebugLogManager sharedManager].enable;
}

+ (void)enable:(BOOL)enable
{
    [EMClickDebugLogManager sharedManager].enable = enable;
}

+ (void)setLog:(EMClickDebugLog *)log withIdentifier:(NSString *)identifier
{
    [[EMClickDebugLogManager sharedManager] setLog:log withIdentifier:identifier];
}

+ (EMClickDebugLog *)logWithIdentifier:(NSString *)identifier
{
    return [[EMClickDebugLogManager sharedManager] logWithIdentifier:identifier];
}


- (void)setLog:(EMClickDebugLog *)log withIdentifier:(NSString *)identifier
{
    [self.cachedLogs setObject:log forKey:identifier];
}

- (EMClickDebugLog *)logWithIdentifier:(NSString *)identifier
{
    return [self.cachedLogs objectForKey:identifier];
}

+ (void)removeLogWithIdentifier:(NSString *)identifier
{
    [[EMClickDebugLogManager sharedManager] removeLogWithIdentifier:identifier];
}

- (void)removeLogWithIdentifier:(NSString *)identifier
{
    [self.cachedLogs removeObjectForKey:identifier];
}

@end
