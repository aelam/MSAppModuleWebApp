//
//  EMClickEvent.m
//  Pods
//
//  Created by ryan on 15/9/30.
//
//

#import "EMClickEvent.h"

@implementation EMClickEvent

+ (NSArray *)eventsWithInfo:(NSArray *)info defaultTarget:(Class)target {
    NSMutableArray *events = [NSMutableArray array];
    for(NSDictionary *e in info) {
        EMClickEvent *event = [[EMClickEvent alloc] init];
        event.eventName = e[@"eventId"];
        event.eventSelector = e[@"selector"];
        event.eventTarget = NSClassFromString(e[@"eventClass"]);
        if (!event.eventTarget) {
            event.eventTarget = target;
        }
        
        [events addObject:event];
    }
    
    return events;
}


@end
