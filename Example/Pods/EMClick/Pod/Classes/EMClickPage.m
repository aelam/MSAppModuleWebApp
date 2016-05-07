//
//  EMClickPage.m
//  Pods
//
//  Created by ryan on 15/9/30.
//
//

#import "EMClickPage.h"
#import "EMClickEvent.h"

@implementation EMClickPage

+ (NSArray *)pagesWithArray:(NSArray *)info {
    NSMutableArray *pages = [NSMutableArray array];
    for(NSDictionary *page in info) {
        EMClickPage *p = [[EMClickPage alloc] initWithInfo:page];
        [pages addObject:p];
    }
    return pages;
}

- (instancetype)initWithInfo:(NSDictionary *)info {
    if (self = [super init]) {
        self.pageId = info[@"pageId"];
        self.pageClass = info[@"pageClass"];
        self.events = [EMClickEvent eventsWithInfo:info[@"events"] defaultTarget:NSClassFromString(self.pageClass)];
    }
    return self;
}

+ (NSArray *)pagesWithPath:(NSString *)path {
    return [[NSArray alloc] initWithContentsOfFile:path];
}

@end
