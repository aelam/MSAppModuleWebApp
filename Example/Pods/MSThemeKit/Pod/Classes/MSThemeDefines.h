//
//  MSThemeDefines.h
//  Pods
//
//  Created by ryan on 2/29/16.
//
//

#ifndef _MSTHEME_DEFINES_H_
#define _MSTHEME_DEFINES_H_

#if TARGET_OS_IPHONE || TARGET_OS_TV

#import <UIKit/UIKit.h>
#define MSThemeImageView UIImageView
#define MSThemeColor     UIColor
#define MSThemeFont      UIFont

#elif TARGET_OS_MAC

#import <AppKit/AppKit.h>
#define MSThemeImageView NSImageView
#define MSThemeColor     NSColor
#define MSThemeFont      NSFont

#endif


#endif /* _MSTHEME_DEFINES_H_ */
