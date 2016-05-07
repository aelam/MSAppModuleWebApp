//
//  EMCoreMacors.h
//  CoreDemo
//
//  Created by Mac mini 2012 on 15-3-4.
//  Copyright (c) 2015年 Mac mini 2012. All rights reserved.
//

#ifndef _MSCOREMACROS_H_
#define _MSCOREMACROS_H_




/**
 *  角度与弧度转换
 */
#if !defined(DegreesToRadian)
#define DegreesToRadian(x) (M_PI * (x) / 180.0)
#endif


/**
 *  获取数组长度
 */
#if !defined(ArrayLength)
#define ArrayLength(x)	(sizeof(x) / sizeof((x)[0]))
#endif


/**
 *  自增
 */
#if !defined(LoopIncrease)
#define LoopIncrease(val,len) (val = ((val)+1 > (len-1)) ? 0 : (val)+1)
#endif


/**
 *  自减
 */
#if !defined(LoopDecrease)
#define LoopDecrease(val,len)  (val = ((val)-1 < 0) ? (len-1) : (val)-1)
#endif


/**
 *  判断是否是偶数
 */
#if !defined(Even)
#define Even(n)  (n%2 == 0) ? 1 : 0
#endif


#define __(x) (x == nil || [x isKindOfClass:[NSNull class]])?nil:[NSString stringWithFormat:@"%@",x]


#endif /* _MSCOREMACROS_H_ */
