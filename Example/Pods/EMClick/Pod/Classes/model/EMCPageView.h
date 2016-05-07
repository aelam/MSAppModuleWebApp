//
//  EMCPageView.h
//  EMClickDemo
//
//  Created by flora on 15/9/15.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EMCPageView : NSObject

@property (nonatomic, strong) NSString *sourceview;
@property (nonatomic, strong) NSString *pageId;

@property (nonatomic, strong) NSDate *enterDate;//yyyy-MM-dd HH:mm:ss
@property (nonatomic, strong) NSDate *exitDate;//yyyy-MM-dd HH:mm:ss
@property (nonatomic, assign) CGFloat duration;

@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, strong) NSString *attributeString;

/**
 *  快速生成PageView
 *
 *  @param pageId
 *  @param attributes 
 *
 *  @return EMCPageView
 */
+ (instancetype)pageWithSourceId:(NSString *)srouceId
                          pageId:(NSString *)pageId;

- (void)finish;
- (BOOL)isFinished;

@end
