//
//  EMClickAspect.m
//  EMClick
//
//  Created by flora on 15/9/17.
//  Copyright (c) 2015年 Ryan Wang. All rights reserved.
//

#import "EMClickAspect.h"
#import "EMClickManager.h"
#import <EMSpeed/MSCoreFileManager.h>
#import "EMClickPage.h"
#import "EMClickEvent.h"

@interface EMClickAspect()

@property (nonatomic, strong) NSDictionary *pageViews;

@end

@implementation EMClickAspect

+ (instancetype)sharedAspect
{
    static dispatch_once_t onceQueue;
    static EMClickAspect *eMClickAspect = nil;
    
    dispatch_once(&onceQueue, ^{ eMClickAspect = [[self alloc] init]; });
    return eMClickAspect;
}

+ (void)registerClick
{
    [[self sharedAspect] registerClickPageEvent];
    [[self sharedAspect] registerClickPageView];
}


- (id)init
{
    self = [super init];
    if (self) {
        self.pageViews = [self pageSettings];
    }
    return self;
}

- (NSString *)pageViewIdForController:(UIViewController *)controller
{
    NSString *pageId = [self.pageViews objectForKey:NSStringFromClass([controller class])];
    return pageId;
}

- (void)trackEventWithClass:(Class)klass
                   selector:(SEL)selector
               eventHandler:(void (^)(id<AspectInfo> aspectInfo))eventHandler
{
    [klass aspect_hookSelector:selector withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
        if (eventHandler) {
            eventHandler(aspectInfo);
        }
    } error:NULL];
}

- (void)trackEvent:(NSString *)event forClass:(Class)klass selector:(SEL)selector
{
    [self trackEvent:event attributes:nil forClass:klass selector:selector];
}

- (void)trackEvent:(NSString *)event attributes:(NSDictionary *)attributes
          forClass:(Class)klass selector:(SEL)selector {
    [self trackEventWithClass:klass selector:selector eventHandler:^(id<AspectInfo> aspectInfo) {
        [[EMClickManager sharedManager] event:event attributes:attributes];
        NSLog(@"event:%@", event);
    }];
}

- (void)registerClickPageView
{
    __weak __typeof (self)weakSelf = self;
    [self trackEventWithClass:[UIViewController class]
                     selector:@selector(viewDidAppear:)
                 eventHandler:^(id<AspectInfo> aspectInfo) {
        UIViewController *controller =  aspectInfo.instance;
        NSString *pageId = [weakSelf pageViewIdForController:controller];
        if (pageId)
        {
            [[EMClickManager sharedManager] beginLogPageView:pageId];
            NSLog(@"beginLogPageView:%@", pageId);

        }
    }];
    
    [self trackEventWithClass:[UIViewController class]
                     selector:@selector(viewDidDisappear:)
                 eventHandler:^(id<AspectInfo> aspectInfo) {
        UIViewController *controller =  aspectInfo.instance;
        NSString *pageId = [weakSelf pageViewIdForController:controller];
        if (pageId)
        {
            [[EMClickManager sharedManager] endLogPageView:pageId attributes:nil];
            NSLog(@"endLogPageView:%@", pageId);
        }
    }];
    
}

#pragma mark - 
#pragma mark project need overwrite to config

- (NSDictionary *)pageSettings;
{
    return [NSDictionary dictionary];
}

- (void)registerClickPageEvent
{
}


@end
