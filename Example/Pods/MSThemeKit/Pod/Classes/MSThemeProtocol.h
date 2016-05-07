//
//  EMThemeUpdateProtocol.h
//  UI
//
//  Created by Samuel on 15/4/13.
//  Copyright (c) 2015年 Samuel. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  场景更新的
 */
@protocol MSThemeProtocol <NSObject>

@required

/**
 *  场景更新, 颜色变化
 */
- (void)applyTheme;

@end

