//
//  UIApplication+AppVersion.h
//  EMSpeed
//
//  Created by ryan on 16/1/14.
//
//

#import <UIKit/UIKit.h>

typedef struct {
    NSInteger majorVersion;
    NSInteger minorVersion;
    NSInteger patchVersion;
} _MSAppVersion;

@interface UIApplication (AppVersion)

@property (nonatomic, assign, readonly) _MSAppVersion appVersion;

@property (nonatomic, strong, readonly) NSString *versionDescription;   // eg. 3.2.1
@property (nonatomic, assign, readonly) NSInteger versionIntVal;

@property (nonatomic, assign, readonly) NSInteger majorVersion;       // 主版本号
@property (nonatomic, assign, readonly) NSInteger minorVersion;       // 子版本号
@property (nonatomic, assign, readonly) NSInteger patchVersion;       // 编译版本号

@end
