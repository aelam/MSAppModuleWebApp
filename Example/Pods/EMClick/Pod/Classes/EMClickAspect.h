//
//  EMClickAspect.h
//  EMClick
//
//  Created by flora on 15/9/17.
//  Copyright (c) 2015年 Ryan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Aspects/Aspects.h>
#import "EMClickManager.h"

@protocol EMClickAspect <NSObject>

+ (void)registerClick;
- (void)registerClickPageView;
- (void)registerClickPageEvent;

@end

@interface EMClickAspect : NSObject<EMClickAspect>


/**
 *页面统计的配置plist文件名称
 */
- (NSDictionary *)pageSettings;

/**
 *注册页面事件
 */
- (void)registerClickPageEvent;

- (void)registerClickPageView;

- (void)trackEventWithClass:(Class)klass
                   selector:(SEL)selector
               eventHandler:(void (^)(id<AspectInfo> aspectInfo))eventHandler;

- (void)trackEvent:(NSString *)event forClass:(Class)klass selector:(SEL)selector;
- (void)trackEvent:(NSString *)event attributes:(NSDictionary *)attributes
          forClass:(Class)klass selector:(SEL)selector;

@end
