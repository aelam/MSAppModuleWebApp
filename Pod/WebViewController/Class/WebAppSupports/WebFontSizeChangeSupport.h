//
//  WebFontSizeChangeSupport.h
//  Pods
//
//  Created by ryan on 16/12/2016.
//
//

#import <Foundation/Foundation.h>

@protocol WebFontSizeChangeSupport <NSObject>

@property (nonatomic, strong) NSNumber *fontSize;

- (void)showChangeFontSizeViewWithSelection:(void (^)(NSString *newFontSize))selection;

@end
