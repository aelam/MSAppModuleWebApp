//
//  EMClickManager.m
//  EMClickDemo
//
//  Created by flora on 15/9/15.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "EMClickManager.h"

#import <YRJSONAdapter/YRJSONAdapter.h>
#import <EMSpeed/MSHTTPResponse.h>
//#import <CRToast/CRToast.h>

#import "NSData+Compress.h"
#import "NSMutableData+postBody.h"
#import "MSCoreFileManager.h"
#import "EMClickDebugLog.h"
#import "EMClickUploadCache.h"


#define kEMCAPP_LAUNCH_PAGEID @"app"
#define kEMCAPP_PAUSE_INTERVAL 30
#define kEMCAPP_REPORT_INTERVAL 120 //间隔上报策略间隔时间
#define kEMCAPP_FILE_NAME @"emclick"
#define kEMCAPP_EVENT_MAX 2048 // 超过2048条丢弃
#define kEMCAPP_DIVIDE_MAX 200 // 分页保存


@interface EMClickManager()
{
    BOOL _isApplicationLaunch;
}

@property (nonatomic, strong) NSMutableArray *pageViews;
@property (nonatomic, strong) NSMutableArray *pageEvents;

@property (nonatomic, strong) EMCPageView *currentPageView;
@property (nonatomic, strong) EMCPageView *lastPageView;
@property (nonatomic, strong) EMCPageView *globalPageView;
@property (nonatomic, strong) NSString *currentPageId;
@property (nonatomic, strong) NSDate *resignActiveDate;

@property (nonatomic, strong) NSMutableDictionary *uploadingData;

@end


@implementation EMClickManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceQueue;
    static EMClickManager *eMClickManager = nil;
    
    dispatch_once(&onceQueue, ^{
        
        NSData *data = [NSData dataWithContentsOfFile:MSPathForCachesResource(kEMCAPP_FILE_NAME)];
        
        if (data)
        {
            eMClickManager = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [eMClickManager loadDefaultSetting];
        }
        else
        {
            eMClickManager = [[self alloc] init];
        }
    });
    return eMClickManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.pageViews = [[NSMutableArray alloc] init];
        self.pageEvents = [[NSMutableArray alloc] init];
        
        self.currentPageView = nil;
        self.globalPageView = nil;
        self.currentPageId = nil;
        
        [self loadDefaultSetting];
    }
    return self;
}

- (void)loadDefaultSetting
{
    self.app = [[EMCAPP alloc] init];
    self.debugEnabled = [[NSUserDefaults standardUserDefaults] boolForKey:kClickManagerDebugEnableKey];

    [self addObserver];
    
    self.reportInterval = kEMCAPP_REPORT_INTERVAL;
}

#pragma mark -
#pragma mark 事件触发

/**
 *  事件触发
 *
 *  @param eventId    事件Id
 *  @param attributes 事件自定义事件
 */
- (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes
{
    EMCPageEvent *event = [EMCPageEvent eventWithId:eventId attributes:attributes];
    [self.pageEvents addObject:event];
    
//    if ([self isDebugEnabled] && [self isLogEnabled]) {
//        [self showEventLog:eventId attributes:attributes];
//    }

    if ([self isMaximumPagesAndEvents]) {
        [self dividePagesAndEvents];
    }
}

#pragma mark -
#pragma mark 页面统计触发
/**
 *  在页面打开的时候调用
 *
 *  @param pageId 页面的唯一id
 */
- (void)beginLogPageView:(NSString *)pageId
{
    self.lastPageView = self.currentPageView;
    
    EMCPageView *pageView = [EMCPageView pageWithSourceId:self.currentPageId pageId:pageId];
    
    self.currentPageView = pageView;
    self.currentPageId = pageId;
    
//    if ([self isDebugEnabled] && [self isLogEnabled]) {
//        [self showBeginPageLog:pageId attributes:nil];
//    }
}

/**
 *  在页面结束的时候调用，可添加自定义数据
 *
 *  @param pageId     页面唯一id
 *  @param attributes 自定义数据
 */
- (void)endLogPageView:(NSString *)pageId attributes:(NSDictionary *)attributes
{
//    if ([self isDebugEnabled] && [self isLogEnabled]) {
//        [self showEndPageLog:pageId attributes:attributes];
//    }

    if (self.lastPageView && [self.lastPageView.pageId isEqualToString:pageId])
    {
        self.lastPageView.attributes = attributes;
        [self.lastPageView finish];
        [self.pageViews addObject:self.lastPageView];
        self.lastPageView = nil;
    }
    else if (self.currentPageView && [self.currentPageView.pageId isEqualToString:pageId])
    {
        self.currentPageView.attributes = attributes;
        [self.currentPageView finish];
        [self.pageViews addObject:self.currentPageView];
        self.currentPageView = nil;
    }
    
    if ([self isMaximumPagesAndEvents]) {
        [self dividePagesAndEvents];
    }
}

#pragma mark -
#pragma mark 上传数据

- (NSString *)userUrlString
{
    if ([self isDebugEnabled])
    {
        return kEMClickReportUserURL_DEBUG;
    }
    else
    {
        return kEMClickReportUserURL;
    }
}

- (NSString *)pageUrlString
{
    if ([self isDebugEnabled])
    {
        return kEMClickReportPageURL_DEBUG;
    }
    else
    {
        return kEMClickReportPageURL;
    }
}

/**
 *  上传用户数据
 */
- (void)uploadUserData
{
    NSData *data = [self userData];
    NSData *postData = [NSMutableData postDataWithAppendBody:data];
    NSDictionary *headerFields = [NSDictionary dictionaryWithObject:@"multipart/form-data; boundary=Boundary+0xAbCdEfGbOuNdArY; charset=utf-8" forKey:@"content-type"];
    
    [self POSTUserInfo:[self userUrlString]
                  data:postData
                fields:headerFields
                 block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
                 }];
}

/**
 *  上传页面统计数据
 */
- (void)uploadPageData
{
    // 剩下的
    if ([self.pageViews count] + [self.pageEvents count] > 0) {
        
        EMClickUploadCache *cu = [[EMClickUploadCache alloc] initWithIdentifier:[NSUUID UUID].UUIDString];
        cu.pageViews = [self.pageViews mutableCopy];
        cu.pageEvents = [self.pageEvents mutableCopy];
        
        [self addClickUpload:cu];
        [self.pageViews removeAllObjects];
        [self.pageEvents removeAllObjects];
    }
    
    // 分页的上传
    for (NSString *key in self.uploadingData) {
        EMClickUploadCache *cu = [self.uploadingData objectForKey:key];
        if (cu.taskIdentifier == nil)
        {
            NSURLSessionTask *task = [self uploadPageViews:cu.pageViews
                                                pageEvents:cu.pageEvents
                                                completion:^(BOOL success) {
                                                    if (success == NO)
                                                    {
                                                        cu.taskIdentifier = nil;
                                                    }
                                                }];
            cu.taskIdentifier = [NSString stringWithFormat:@"%zd", task.taskIdentifier];
        }
    }
}

- (NSURLSessionTask *)uploadPageViews:(NSArray *)pageViews
                           pageEvents:(NSArray *)pageEvents
                           completion:(void (^)(BOOL success))completion
{
    if ([pageViews count] + [pageEvents count] == 0) {
        return nil;
    }
    
    NSDictionary *jsonDict = [self dictionaryWithPageViews:pageViews
                                                pageEvents:pageEvents];
    NSData *data = [self dataWithJSON:jsonDict];
    NSData *postData = [NSMutableData postDataWithAppendBody:data];
    NSDictionary *headerFields = [NSDictionary dictionaryWithObject:@"multipart/form-data; boundary=Boundary+0xAbCdEfGbOuNdArY; charset=utf-8" forKey:@"content-type"];
    
    return [self POSTPagesAndEvents:[self pageUrlString]
                               data:postData
                             fields:headerFields
                          debugInfo:@{@"json":jsonDict, @"pages":@([pageViews count]), @"events":@([pageEvents count])}
                              block:^(MSHTTPResponse *response, NSURLSessionTask *task, BOOL success)
            {
                BOOL completionSuccess  = NO;
                
                if ((success && response.status == MSHTTPResponseStatusOK)
                    || (!success && [self totalPagesAndEvents] >= kEMCAPP_EVENT_MAX))// 失败且超过一定数
                {
                    completionSuccess = YES;
                    [self clearClickUploadWithTaskIdentifier:[NSString stringWithFormat:@"%zd", task.taskIdentifier]];
                }
                
                if (self.reportPolicy == EMReportPolicyInterval)
                {
                    [self uploadPageDataWithInterval];
                }
                
                if (completion)
                {
                    completion(completionSuccess);
                }
            }];
}

/**
 *  当上传策略为间隔上传时调用，当上传结束后，延时指定周期上传行为数据
 */
- (void)uploadPageDataWithInterval
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(uploadPageData) object:nil];
    [self performSelector:@selector(uploadPageData) withObject: nil afterDelay:self.reportInterval];
}

- (void)clearHistory
{
    [self.uploadingData removeAllObjects];
    [self.pageViews removeAllObjects];
    [self.pageEvents removeAllObjects];
}

#pragma mark -
#pragma mark user data private

- (NSString *)dateFormatString:(NSDate *)date
{//yyyy-MM-dd HH:mm:ss
    NSString *string = @"";
    
    if (date)
    {
        NSDateFormatter * g_clickformatter = nil;
        if (g_clickformatter == nil)
        {
            g_clickformatter = [[NSDateFormatter alloc] init];
            [g_clickformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
        string = [g_clickformatter stringFromDate:date];
    }
    return string;
}


- (NSData *)userData
{
    NSMutableDictionary *userPropertys = [NSMutableDictionary dictionary];

    userPropertys[@"username"] = @"";
    userPropertys[@"userid"] = @"";
    userPropertys[@"logintype"] = [NSNumber numberWithInteger:-1];;
    
    userPropertys[@"version"] = _app.version;
    userPropertys[@"systemversion"] = _app.systemversion;
    
    userPropertys[@"channle"] = [NSNumber numberWithInteger:_app.channel];
    userPropertys[@"productid"] = [NSNumber numberWithInteger:_app.productId];
    userPropertys[@"platformid"] = [NSNumber numberWithInteger:_app.platformId];
    
    userPropertys[@"guid"] = _app.guid;
    if (_app.idfa)
    {
        userPropertys[@"idfa"] = _app.idfa;
    }
    userPropertys[@"model"] = _app.model;
    userPropertys[@"network"] = _app.network;
    userPropertys[@"resolution"] = _app.resolution;
    userPropertys[@"starttime"] = [self dateFormatString:_app.launchDate];

    if (self.userAttributes)
    {
        [userPropertys addEntriesFromDictionary:self.userAttributes];
    }
    
    NSData *data = [userPropertys JSONData];
    data = [data compressData];
    return data;
}

- (NSData *)dataWithPageViews:(NSArray *)originPageViews
                   pageEvents:(NSArray *)originPageEvents
{
    NSDictionary *dict = [self dictionaryWithPageViews:originPageViews pageEvents:originPageEvents];
    return [self dataWithJSON:dict];
}

- (NSDictionary *)dictionaryWithPageViews:(NSArray *)originPageViews
                               pageEvents:(NSArray *)originPageEvents
{
    NSArray *pageViewKeys = [self pageViewKeys];
    NSArray *pageViewValues = [self pageViewValues:originPageViews];
    NSArray *pageEventKeys = [self pageEventKeys];
    NSArray *pageEventValues = [self pageEventValues:originPageEvents];
    
    NSDictionary *pageEvents = [NSDictionary dictionaryWithObjectsAndKeys:pageViewKeys,@"pagekey",
                                pageViewValues,@"pagevalue",
                                pageEventKeys,@"eventkey",
                                pageEventValues,@"eventvalue",nil];
    
    NSMutableDictionary *reuslts = [NSMutableDictionary dictionary];
    [reuslts addEntriesFromDictionary:self.userAttributes];
    [reuslts setObject:self.app.guid forKey: @"guid"];
    [reuslts setObject:pageEvents forKey:@"data"];
    reuslts[@"productid"] = [NSNumber numberWithInteger:_app.productId];
    reuslts[@"platformid"] = [NSNumber numberWithInteger:_app.platformId];
    reuslts[@"version"] = _app.version;
    reuslts[@"systemversion"] = _app.systemversion;
    
    return reuslts;
}

- (NSData *)dataWithJSON:(NSDictionary *)json
{
    NSData *data = [json JSONData];
    data = [data compressData];
    return data;
}


- (NSArray*)pageViewKeys
{
    return @[@"SourceView",@"TargetView",@"EnterTime",@"QuitTime",@"Duration",@"Attribute"];
}

- (NSArray*)pageEventKeys
{
    return @[@"EventId",@"Attribute",@"EventDate"];
}

- (NSArray*)pageEventValues:(NSArray *)pageEvents
{
    NSMutableArray *evs = [NSMutableArray array];
    for (EMCPageEvent *ev in pageEvents)
    {
        NSString *attributeString = ev.attributeString ? ev.attributeString : @"";
        NSString *dateString = [self dateFormatString:ev.eventDate];
        NSArray *value = @[ev.eventId,attributeString,dateString];
        [evs addObject:value];
    }
    return evs;
}

- (NSArray*)pageViewValues:(NSArray *)pageViews
{
    NSMutableArray *evs = [NSMutableArray array];

    for (EMCPageView *pv in pageViews)
    {
        NSString *sourceView = pv.sourceview ? pv.sourceview : @"";
        NSString *pageId = pv.pageId ? pv.pageId : @"";
        NSString *enterTime = [self dateFormatString:pv.enterDate];
        NSString *quittime = [self dateFormatString:pv.exitDate];
        NSString *duration = @"";
        if (pv.enterDate && pv.exitDate)
        {
            NSTimeInterval interval = [pv.exitDate timeIntervalSinceDate:pv.enterDate];
            duration = [NSString stringWithFormat:@"%f",(CGFloat)interval];
        }
        NSString *attributeString = pv.attributeString ? pv.attributeString : @"";
        NSArray *value = @[sourceView,pageId,enterTime,quittime,duration,attributeString];
        [evs addObject:value];
    }
    return evs;
}


#pragma mark -
#pragma mark notification

- (void)dealloc
{
    [self removeObserver];
}

- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching) name:UIApplicationDidFinishLaunchingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    
}

- (void)removeObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationDidFinishLaunching
{
    _isApplicationLaunch = YES;
}

- (void)applicationDidBecomeActive
{
    BOOL launch = [self isAPPLaunched];
    
    if (launch)
    {
        [self launchAPP];
        [self uploadUserData];
        [self uploadPageData];
    }
    self.resignActiveDate = nil;
    _isApplicationLaunch = NO;
}


- (void)applicationWillResignActive
{
    self.resignActiveDate = [NSDate date];
    
    [self endLastAppPageView];
    [self endGlobalPageView];
    
    //保存本次数据
    [self save];
}

- (void)applicationWillTerminate
{
    [self endLastAppPageView];
    [self endGlobalPageView];
    self.currentPageId = nil;
    //保存本次数据
    [self save];
}

/**
 *  30s内的重新打开不视为一次重新启动
 *
 *  @return BOOL
 */
- (BOOL)isAPPLaunched
{
    BOOL launch = YES;
//    暂时去掉30s后台判断，可能会引起在分享、第三方登录时的错误登录频次数据
//    if (_isApplicationLaunch == NO ||self.resignActiveDate)
//    {//30s 不处理为退出事件。
//        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.resignActiveDate];
//        if (interval <= kEMCAPP_PAUSE_INTERVAL)
//        {
//            launch = NO;
//        }
//    }
    return launch;
}

- (void)launchAPP
{
    self.app.launchDate = [NSDate date];// 记录启动时间
    [self beginAppPage]; // 开启新的生命周期和页面统计
}

- (void)endLastAppPageView
{
    // 保存之前的页面统计, 加入列表中
    if (self.currentPageView)
    {
        [self.currentPageView finish];
        [self.pageViews addObject:self.currentPageView];
        self.currentPageView = nil;
    }
}

- (void)endGlobalPageView
{
    if (self.globalPageView)
    {
        if (self.currentPageId)
        {
            self.globalPageView.attributes = [NSDictionary dictionaryWithObject:self.currentPageId forKey:@"exitPageId"];
        }
        
        [self.globalPageView finish];
        
        // 保存之前的全局页面统计, 加入列表中
        [self.pageViews addObject:self.globalPageView];
        self.globalPageView = nil;
    }
}

- (void)beginAppPage
{
    // 开始新的app 周期统计
    self.globalPageView = [EMCPageView pageWithSourceId:self.currentPageId
                                                 pageId:kEMCAPP_LAUNCH_PAGEID];
    
    // 开始新的页面统计
    if (self.currentPageId)
    {
        NSString *pageId = self.currentPageId;
        if (_isApplicationLaunch == NO)
        {
            [self beginLogPageView:pageId];
        }
    }
}

#pragma mark -
#pragma mark file
//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.pageViews forKey:@"pageViews"];
    [encoder encodeObject:self.pageEvents forKey:@"pageEvents"];
    [encoder encodeObject:self.currentPageView forKey:@"currentPageView"];
    [encoder encodeObject:self.globalPageView forKey:@"globalPageView"];
    [encoder encodeObject:self.currentPageId forKey:@"currentPageId"];
    [encoder encodeObject:self.resignActiveDate forKey:@"resignActiveDate"];
    [encoder encodeObject:self.userAttributes forKey:@"userAttributes"];
    [encoder encodeObject:self.uploadingData forKey:@"uploadingData"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.pageViews = [decoder decodeObjectForKey:@"pageViews"];
        self.pageEvents = [decoder decodeObjectForKey:@"pageEvents"];
        self.currentPageView = [decoder decodeObjectForKey:@"currentPageView"];
        self.globalPageView = [decoder decodeObjectForKey:@"globalPageView"];
        self.currentPageId = [decoder decodeObjectForKey:@"currentPageId"];
        self.resignActiveDate = [decoder decodeObjectForKey:@"resignActiveDate"];
        self.userAttributes = [decoder decodeObjectForKey:@"userAttributes"];
        self.uploadingData = [decoder decodeObjectForKey:@"uploadingData"];
    }
    return self;
}

- (void)save
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSError *error = nil;
    BOOL success = [data writeToFile:MSPathForCachesResource(kEMCAPP_FILE_NAME)
                          options:NSDataWritingAtomic
                            error:&error];

    if (!success) {
        NSLog(@"save click failed! error = %@", [error localizedDescription]);
    }
}


#pragma mark - for debug
// 添加事件到上传的字典中
- (void)addClickUpload:(EMClickUploadCache *)cu
{
    NSAssert(cu && [cu.identifier length]>0, @"cu and cu.identifier can not be null!");

    if (cu==nil || cu.identifier==nil) {
        return;
    }
    
    if (!self.uploadingData) {
        self.uploadingData = [NSMutableDictionary dictionary];
    }
    [self.uploadingData setObject:cu forKey:cu.identifier];
}


// 减去对应的事件
//- (void)minusUploadingEventsWithKey:(NSString *)key
//{
//    if
//    
//    EMClickUploadCache *cu = [self.uploadingData objectForKey:key];
//    
//    if ([cu.identifier isEqualToString:key]) {
//        [self.pageViews removeObjectsInArray:cu.pageViews];
//        [self.pageEvents removeObjectsInArray:cu.pageEvents];
//        
//        [self.uploadingData removeObjectForKey:key];
//    }
//}

- (BOOL)isMaximumPagesAndEvents
{
    return [self.pageViews count] + [self.pageEvents count] >= kEMCAPP_DIVIDE_MAX;
}

// 分割 pageEvents & pageEvents
- (void)dividePagesAndEvents
{
    EMClickUploadCache *cu = [[EMClickUploadCache alloc] initWithIdentifier:[NSUUID UUID].UUIDString];
    cu.pageViews = [self.pageViews mutableCopy];
    cu.pageEvents = [self.pageEvents mutableCopy];
    
    [self.pageViews removeAllObjects];
    [self.pageEvents removeAllObjects];
    
    [self addClickUpload:cu];
}


- (void)clearClickUploadWithTaskIdentifier:(NSString *)identifier
{
    EMClickUploadCache *obj = nil;
    for (NSString *key in self.uploadingData) {
        EMClickUploadCache *cu = [self.uploadingData objectForKey:key];
        if ([cu.taskIdentifier isEqualToString:identifier]) {
            obj = cu;
            break;
        }
    }
    
    if (obj && obj.identifier) {
        [self.uploadingData removeObjectForKey:obj.identifier];
    }
    else{
        NSLog(@"clearClickUploadWithTaskIdentifier [%@] not found!", identifier);
    }
}

- (int)totalPagesAndEvents
{
    int count = 0;
    for (NSString *key in self.uploadingData) {
        EMClickUploadCache *ud = [self.uploadingData objectForKey:key];
        count += [ud.pageViews count];
        count += [ud.pageEvents count];
    }
    
    count += [self.pageViews count];
    count += [self.pageEvents count];
    
    return count;
}

@end

