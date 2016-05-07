//
//  UnderlineUIButton.h
//  EMStock
//
//  Created by flora deng on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.


#import <Foundation/Foundation.h>

/**
 *  有下划线的按钮
 */
@interface MSLinkedButton : UIButton {
    
}

/**
 *  设置url, 自动添加跳转方法
 */
@property (nonatomic, strong) NSString *url;


/**
 *  y轴上下偏移
 */
@property (nonatomic, assign) CGFloat offsetY;


/**
 *  线颜色值, 默认为文本的颜色值
 */
@property (nonatomic, strong) UIColor *linkedLineColor;


/**
 *  高亮
 */
@property (nonatomic, strong) UIColor *linkedLineHighLightColor;


@end
