//
//  EMClick+Mobclick.h
//  Pods
//
//  Created by Lyy on 16/1/8.
//
//

#if (TARGET_IPHONE_SIMULATOR == 1)
//#define HAS_MOBCLICK 0
#else
#define HAS_MOBCLICK 1
#endif

#import "EMClick.h"

/**
 *  友盟统计
 */

@interface EMClick (Mobclick)

/**
 *  启动友盟统计初始化模块
 *  该方法会做一些初始化配置，你也可以调用下面的API去修改这些默认的设置
 *  1. 开启CrashReport收集
 *  2. DEBUG 模式下 打印sdk的log信息
 *  @param reportPolicy 发送策略, 默认值为：EMReportPolicyLaunch，即“启动发送”模式
 *  @param channel      channelId 渠道名称,为nil或@""时, 默认为@"App Store"渠道
 */
+ (void)startUMAnalycisConfigWithAppKey:(NSString *)appkey
                           reportPolicy:(EMReportPolicy)reportPolicy
                                channel:(NSInteger)channel;

///---------------------------------------------------------------------------------------
/// @name  设置
///---------------------------------------------------------------------------------------

/** 设置app版本号。由于历史原因需要和xcode3工程兼容,友盟提取的是Build号(CFBundleVersion)，
 如果需要和App Store上的版本一致,请调用此方法。
 @param appVersion 版本号，例如设置成`XcodeAppVersion`.
 @return void.
 */
+ (void)setAppVersion:(NSString *)appVersion;

/** 开启CrashReport收集, 默认YES(开启状态).
 @param value 设置为NO,可关闭友盟CrashReport收集功能.
 @return void.
 */
+ (void)setCrashReportEnabled:(BOOL)value;

/** 设置是否打印sdk的log信息, 默认NO(不打印log).
 @param value 设置为YES,umeng SDK 会输出log信息可供调试参考. 除非特殊需要，否则发布产品时需改回NO.
 @return void.
 */
+ (void)setLogEnabled:(BOOL)value;

/** 设置是否开启background模式, 默认YES.
 @param value 为YES,SDK会确保在app进入后台的短暂时间保存日志信息的完整性，对于已支持background模式和一般app不会有影响.
 如果该模式影响某些App在切换到后台的功能，也可将该值设置为NO.
 @return void.
 */
+ (void)setBackgroundTaskEnabled:(BOOL)value;

/** 设置是否对日志信息进行加密, 默认NO(不加密).
 @param value 设置为YES, umeng SDK 会将日志信息做加密处理
 @return void.
 */
+ (void)setEncryptEnabled:(BOOL)value;

/** 当reportPolicy == SEND_INTERVAL 时设定log发送间隔
 @param second 单位为秒,最小90秒,最大86400秒(24hour).
 @return void.
 */
+ (void)setLogSendInterval:(double)second;

/** 设置日志延迟发送
 @param second 设置一个[0, second]范围的延迟发送秒数，最大值1800s.
 @return void
 */
+ (void)setLatency:(int)second;

@end
