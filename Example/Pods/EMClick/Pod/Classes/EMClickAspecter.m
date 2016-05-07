//
//  EMClickAspecter.m
//  Pods
//
//  Created by ryan on 15/10/9.
//
//

#import "EMClickAspecter.h"
#import "EMClickEvent.h"
#import "EMClickPage.h"

@interface EMClickAspecter ()

@property (nonatomic, strong) NSArray *pageMapping;

@end

@implementation EMClickAspecter

+ (instancetype)sharedAspect
{
    static dispatch_once_t onceQueue;
    static EMClickAspecter *eMClickAspect = nil;
    
    dispatch_once(&onceQueue, ^{ eMClickAspect = [[self alloc] init]; });

    return eMClickAspect;
}

+ (void)loadPageSettingsWithPaths:(NSArray *)paths {
    NSMutableArray *p = [NSMutableArray array];
    for(NSString *path in paths) {
        NSArray *pageArray = [[NSArray alloc] initWithContentsOfFile:path];
        [p addObjectsFromArray:pageArray];
    }
    
    EMClickAspecter *aspect = [self sharedAspect];
    aspect.pageMapping = [EMClickPage pagesWithArray:p];
}

- (NSString *)pageViewIdForController:(UIViewController *)controller {
    for(EMClickPage *page in self.pageMapping) {
        if([page.pageClass isEqualToString:NSStringFromClass([controller class])]) {
            return page.pageId;
        }
    }
    return nil;
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
                         NSLog(@"beginLogPageView: %@", pageId);
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
                         NSLog(@"endLogPageView: %@", pageId);

                     }
                 }];
    
}

- (void)registerClickPageEvent
{
    for(EMClickPage *page in self.pageMapping) {
        for(EMClickEvent *event in page.events) {
            [self trackEvent:event.eventName forClass:event.eventTarget selector:NSSelectorFromString(event.eventSelector)];
        }
    }
}


@end
