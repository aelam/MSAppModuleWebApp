//
//  EMClickLog.h
//  Pods
//
//  Created by Mac mini 2012 on 15/11/20.
//
//

#import <Foundation/Foundation.h>


#define EMClickDebugLogEnable 1
#define kClickManagerLogEnableKey   @"kClickManagerLogEnableKey"


@interface EMClickDebugLog : NSObject 

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSString *server;

@property (nonatomic, assign) BOOL successful;
@property (nonatomic, strong) NSError *error;

@property (nonatomic, assign) int numberOfEvents;
@property (nonatomic, assign) int numberOfPages;

@property (nonatomic, strong) NSString *updateTypeName;

@property (nonatomic, strong) NSDictionary *json;

- (BOOL)saveToLocal;

@end


@interface EMClickDebugLogManager : NSObject


+ (BOOL)isEnable;
+ (void)enable:(BOOL)enable;

+ (void)setLog:(EMClickDebugLog *)log withIdentifier:(NSString *)identifier;
+ (EMClickDebugLog *)logWithIdentifier:(NSString *)identifier;

+ (void)removeLogWithIdentifier:(NSString *)identifier;

@end
