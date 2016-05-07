//
//  NSTimer+Pause.h
//  EMStock
//
//  Created by ryan on 15/8/24.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Pause)

- (void)pause;
- (void)resumeInDate:(NSDate *)date;

@end
