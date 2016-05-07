//
//  EMClickEvent.h
//  Pods
//
//  Created by ryan on 15/9/30.
//
//

#import <Foundation/Foundation.h>
#import <objc/objc.h>

@interface EMClickEvent : NSObject

@property (nonatomic, strong) NSString *eventSelector;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) Class eventTarget; // class

+ (NSArray *)eventsWithInfo:(NSArray *)info defaultTarget:(Class)target;

@end
