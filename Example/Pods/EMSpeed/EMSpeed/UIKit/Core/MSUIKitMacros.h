//
//  MSUIKitMacros.h
//  CoreDemo
//
//  Created by Mac mini 2012 on 15-3-4.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#ifndef _MSUIKITMACROS_H_
#define _MSUIKITMACROS_H_

#define MSUIResName(file) [@"MSUIResources.bundle" stringByAppendingPathComponent:file]

/**
 *  根据rgb值获取颜色的封装函数
 */
#if !defined(RGBA)
#define RGBA(r,g,b,a) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]
#define RGB(r,g,b)     RGBA(r,g,b,1)
#endif

#endif /* _MSUIKITMACROS_H_ */
