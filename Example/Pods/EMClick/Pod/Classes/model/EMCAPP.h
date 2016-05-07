//
//  EMCAPP.h
//  EMClickDemo
//
//  Created by flora on 15/9/15.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define EMUSEIDFA

@interface EMCAPP : NSObject

@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *systemversion;

@property (nonatomic, assign) NSInteger channel;
@property (nonatomic, assign) NSInteger productId;
@property (nonatomic, assign) NSInteger platformId;

@property (nonatomic, strong) NSDate *launchDate;

@property (nonatomic, strong) NSString *guid;
@property (nonatomic, strong) NSString *idfa;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *network;
@property (nonatomic, strong) NSString *resolution;


@end
