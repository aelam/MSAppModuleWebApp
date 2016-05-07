//
//  EMClickPage.h
//  Pods
//
//  Created by ryan on 15/9/30.
//
//

#import <Foundation/Foundation.h>

@interface EMClickPage : NSObject

@property (nonatomic, strong) NSString *pageClass;
@property (nonatomic, strong) NSString *pageId;
@property (nonatomic, strong) NSArray  *events;

+ (NSArray *)pagesWithArray:(NSArray *)array;

@end


