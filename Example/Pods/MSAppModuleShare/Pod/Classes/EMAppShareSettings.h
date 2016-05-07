//
//  EMAppShareSettings.h
//  Pods
//
//  Created by ryan on 16/1/8.
//
//

#import <Foundation/Foundation.h>

@class EMSocialDefaultConfigurator;
@protocol MSAppSettings;

@protocol EMAppShareSettings <MSAppSettings>

@property (nonatomic, strong) EMSocialDefaultConfigurator *shareConfigurator;
@property (nonatomic, strong) NSString *theme; // white or black
@property (nonatomic, assign) NSInteger productID;

@end
