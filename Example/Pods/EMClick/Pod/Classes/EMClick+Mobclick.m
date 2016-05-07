//
//  EMClick+Mobclick.m
//  Pods
//
//  Created by Lyy on 16/1/8.
//
//

#import "EMClick+Mobclick.h"
#ifdef HAS_MOBCLICK
#import <MobClick.h>
#endif

@implementation EMClick (Mobclick)

+ (void)startUMAnalycisConfigWithAppKey:(NSString *)appkey
                           reportPolicy:(EMReportPolicy)reportPolicy
                                channel:(NSInteger)channel {
#ifdef HAS_MOBCLICK
    
    // 如果不需要捕捉异常，注释掉此行
    [MobClick setCrashReportEnabled:YES];
#ifdef DEBUG
    // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setLogEnabled:YES];
#endif
    //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //    [MobClick setAppVersion:XcodeAppVersion];
    
    NSString *channelId = [NSString stringWithFormat:@"%@",@(channel)];
    ReportPolicy policy = BATCH;
    if (reportPolicy == EMReportPolicyLaunch) {
        policy = BATCH;
    } else if (reportPolicy == EMReportPolicyInterval) {
        policy = SEND_INTERVAL;
    }
    NSAssert(appkey, @"appkey cann't be nil");
    [MobClick startWithAppkey:appkey reportPolicy:policy channelId:channelId];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
#endif /* HAS_MOBCLICK */
}

+ (void)setAppVersion:(NSString *)appVersion {
#ifdef HAS_MOBCLICK
    [MobClick setAppVersion:appVersion];
#endif /* HAS_MOBCLICK */
}

+ (void)setCrashReportEnabled:(BOOL)value {
#ifdef HAS_MOBCLICK
    [MobClick setCrashReportEnabled:value];
#endif /* HAS_MOBCLICK */
}

+ (void)setLogEnabled:(BOOL)value {
#ifdef HAS_MOBCLICK
    [MobClick setLogEnabled:value];
#endif /* HAS_MOBCLICK */
}

+ (void)setBackgroundTaskEnabled:(BOOL)value {
#ifdef HAS_MOBCLICK
    [MobClick setBackgroundTaskEnabled:value];
#endif /* HAS_MOBCLICK */
}

+ (void)setEncryptEnabled:(BOOL)value {
#ifdef HAS_MOBCLICK
    [MobClick setEncryptEnabled:value];
#endif /* HAS_MOBCLICK */
}

+ (void)setLogSendInterval:(double)second {
#ifdef HAS_MOBCLICK
    [MobClick setLogSendInterval:second];
#endif /* HAS_MOBCLICK */
}
+ (void)setLatency:(int)second {
#ifdef HAS_MOBCLICK
    [MobClick setLatency:second];
#endif /* HAS_MOBCLICK */
}

@end
