//
//  EMCoreContext.h
//  EMStock
//
//  Created by flora on 14-9-11.
//  Copyright (c) 2014年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * UITextAlignment 扩展
 */

typedef NS_OPTIONS(NSInteger, MSTextVerticalAlignment) {
    MSTextVerticalAlignmentCenter = 1<<5,//垂直居中
    MSTextVerticalAlignmentBottom = 1<<6,//垂直靠底
};


/**
 * 箭头方向
 */
typedef NS_ENUM(NSInteger, MSArrowDirection) {
    MSArrowDirectionNone = 0,   // 没有箭头
    MSArrowDirectionDown,       // 剪头向下
    MSArrowDirectionUp,         // 剪头向上
    MSArrowDirectionLeft,       // 剪头向左
    MSArrowDirectionRight       // 剪头向右
};


/**
 * 分别用于描述一个圆角矩形四个角的弧度
 */
typedef struct UIRectRadius {
    CGFloat topLeft, topRight, bottomLeft, bottomRight; //定义角度
} UIRectRadius;


#ifdef __cplusplus
extern "C" {
#endif

    
    /**
     *  创建一个圆角矩形
     *
     *  @param topLeft     上左
     *  @param topRight    上右
     *  @param bottomLeft  下左
     *  @param bottomRight 下右
     *
     *  @return 创建一个圆角矩形
     */
//UIRectRadius UIRectRadiusMake(CGFloat topLeft, CGFloat topRight, CGFloat bottomLeft, CGFloat bottomRight);
    
    /**
     判断四个弧度是否相同
     */
//BOOL UIRectRadiusEqualToRectRadius(UIRectRadius radius1, UIRectRadius radius2);
    

CGRect Point2Rect(CGRect boundingRect, CGPoint point, int nAnchor,UIFont *font);

/**
 *  根据字符串和字体计算出所需要的尺寸
 *
 *  @param str  字符串
 *  @param font 字体
 *
 *  @return 尺寸
 */
CGSize sizeWithFont(NSString* str, UIFont* font);


/**
 *  画线(有锯齿)
 *
 *  @param context 上下文
 *  @param x1      点1 x坐标
 *  @param y1      点1 y坐标
 *  @param x2      点2 x坐标
 *  @param y2      点2 y坐标
 *  @param color   颜色
 */
void CGDrawLine( CGContextRef context,int x1,int y1,int x2,int y2,UIColor* color);


/**
 *  画线(开启抗锯齿)
 *
 *  @param context 上下文
 *  @param x1      点1 x坐标
 *  @param y1      点1 y坐标
 *  @param x2      点2 x坐标
 *  @param y2      点2 y坐标
 *  @param color   颜色
 */
void CGDrawLineSmooth( CGContextRef context,int x1,int y1,int x2,int y2,UIColor* color);


/**
 *  画点-破折线
 *
 *  @param context 上下文
 *  @param x1      点1 x坐标
 *  @param y1      点1 y坐标
 *  @param x2      点2 x坐标
 *  @param y2      点2 y坐标
 *  @param color   颜色
 *  @param dash    破折线,点的比例
 *  @param count   元素中的个数
 */
void CGDrawDotLineDash(CGContextRef context,int x1,int y1,int x2,int y2,UIColor *color,CGFloat dash[],int count);


/**
 *  画点-破折线, 同CGDrawDotLineDash, 线和空白的比例为3px:3px
 *
 *  @param context 上下文
 *  @param x1      点1 x坐标
 *  @param y1      点1 y坐标
 *  @param x2      点2 x坐标
 *  @param y2      点2 y坐标
 *  @param color   颜色
 */
void CGDrawDotLine( CGContextRef context,int x1,int y1,int x2,int y2,UIColor *color);


/**
 *  画边框
 *
 *  @param context 上下文
 *  @param rt      区域
 *  @param color   颜色
 */
void CGDrawRect(CGContextRef context,CGRect rt,UIColor *color);


/**
 *  填充边框
 *
 *  @param context 上下文
 *  @param rt      区域
 *  @param color   颜色
 */
void CGFillRect(CGContextRef context,CGRect rt,UIColor *color);


/**
 *  填充带描边的边框
 *
 *  @param context 上下文
 *  @param rt      区域
 *  @param color   颜色
 */
void CGFillStrokeRect(CGContextRef context,CGRect rt,UIColor *color);


/**
 *  绘制三角形
 *
 *  @param context 上下文
 *  @param cDirect 方向
 *  @param rect    区域
 *  @param color   颜色
 */
void CGDrawFillTrianle(CGContextRef context, MSArrowDirection cDirect, CGRect rect, UIColor *color);


/**
 *  绘制菱形
 *
 *  @param context 上下文
 *  @param nX      x坐标
 *  @param nY      y坐标
 *  @param width   宽度
 *  @param height  高度
 *  @param color   颜色
 */
void CGDrawFillDiamond(CGContextRef context, int nX, int nY, int width, int height, UIColor *color);


/**
 *  绘制一个梯形, 上窄下宽
 *
 *  @param context 上下文
 *  @param nX      左上角的x坐标
 *  @param nY      左上角的y坐标
 *  @param w       宽度
 *  @param h       高度
 *  @param color   颜色
 */
void CGDrawLad(CGContextRef context,int nX, int nY,int w, int h,UIColor* color);


/**
 *  填充一个梯形, 上窄下宽
 *
 *  @param context 上下文
 *  @param nX      左上角的x坐标
 *  @param nY      左上角的y坐标
 *  @param w       宽度
 *  @param h       高度
 *  @param color   颜色
 */
void CGFillLad(CGContextRef context,int nX, int nY,int w, int h,UIColor* color);


/**
 *  画字符串
 *
 *  @param str     字符串
 *  @param nX      x坐标
 *  @param nY      y坐标
 *  @param nAnchor 锚点
 *  @param color   颜色
 *  @param font    字体
 */
//    void CGDrawString(NSString* str ,int nX, int nY, int nAnchor, UIColor *color, UIFont *font) __deprecated;
void CGDrawString(CGRect boundingRect, NSString* str ,CGPoint point, int nAnchor, UIColor *color, UIFont *font);


/**
 *  画字符串
 *
 *  @param str     字符串
 *  @param rt      区域
 *  @param nAnchor 锚点
 *  @param color   颜色
 *  @param font    字体
 */
void CGDrawStringInRect(NSString* str ,CGRect rt, int nAnchor, UIColor *color, UIFont *font);


/**
 *  画个渐变区域
 *
 *  @param rect      区域
 *  @param compnents 颜色组
 */
void CGDarwGradientRect(CGRect rect,CGFloat compnents[8]);


/**
 *  画有阴影的文字
 *
 *  @param text         文字
 *  @param textColor    颜色
 *  @param shadowColor  阴影颜色
 *  @param font         字体
 *  @param point        位置
 *  @param nAnchor      锚点
 *  @param shadowOffset 阴影偏移
 *
 *  @return 文字尺寸
 */
CGSize CGDrawTextWithShadow( NSString *text, UIColor  *textColor, UIColor *shadowColor, UIFont *font, CGPoint point, int nAnchor, CGSize shadowOffset);


/**
 *  画个框
 *
 *  @param context 上下文
 *  @param x1      坐标1 x
 *  @param y1      坐标1 y
 *  @param x2      坐标2 x
 *  @param y2      坐标2 y
 *  @param color   颜色
 */
void CGDrawRectExt(CGContextRef context,int x1,int y1,int x2,int y2,UIColor *color);


/**
 *  填充框
 *
 *  @param context 上下文
 *  @param x1      坐标1 x
 *  @param y1      坐标1 y
 *  @param x2      坐标2 x
 *  @param y2      坐标2 y
 *  @param color   颜色
 */
void CGFillRectExt(CGContextRef context,int x1,int y1,int x2,int y2,UIColor *color);


/**
 *  填充框并描边
 *
 *  @param context 上下文
 *  @param x1      坐标1 x
 *  @param y1      坐标1 y
 *  @param x2      坐标2 x
 *  @param y2      坐标2 y
 *  @param color   颜色
 */
void CGFillStrokeRectExt(CGContextRef context,int x1,int y1,int x2,int y2,UIColor *color);


/**
 *  填充弧形
 *
 *  @param context    上下文
 *  @param x          坐标 x
 *  @param y          坐标 y
 *  @param radius     弧度
 *  @param startAngle 起始角度
 *  @param endAngle   结束角度
 *  @param clockwise  顺时针
 *  @param color      颜色
 */
void CGFillArc(CGContextRef context,CGFloat x,CGFloat y, CGFloat radius,
                  CGFloat startAngle,CGFloat endAngle,int clockwise,UIColor *color);


/**
 *  画弧形
 *
 *  @param context    上下文
 *  @param x          坐标 x
 *  @param y          坐标 y
 *  @param radius     弧度
 *  @param startAngle 起始角度
 *  @param endAngle   结束角度
 *  @param clockwise  顺时针
 *  @param color      颜色
 */
void CGDrawArc(CGContextRef context,CGFloat x,CGFloat y, CGFloat radius,
                  CGFloat startAngle,CGFloat endAngle,int clockwise,UIColor *color);

/**
 *  画线(有锯齿)
 *
 *  @param context 上下文
 *  @param x1      坐标 x1
 *  @param y1      坐标 y1
 *  @param x2      坐标 x2
 *  @param y2      坐标 y2
 *  @param color   颜色
 */
void CGDrawLine( CGContextRef context,int x1,int y1,int x2,int y2,UIColor* color);


/**
 *  画线(抗锯齿)
 *
 *  @param context 上下文
 *  @param x1      坐标 x1
 *  @param y1      坐标 y1
 *  @param x2      坐标 x2
 *  @param y2      坐标 y2
 *  @param color   颜色
 */
void CGDrawLineSmooth( CGContextRef context,int x1,int y1,int x2,int y2,UIColor* color);


/**
 *  画圆角区域
 *
 *  @param context     上下文
 *  @param roundRect   区域
 *  @param corners     圆角位置
 *  @param cornerRadii 圆角尺寸
 *  @param bgcolor     颜色
 *  @param borderColor 边框颜色
 */
void CGDrawRoundRect(CGContextRef context,CGRect roundRect,UIRectCorner corners,CGSize cornerRadii,UIColor* bgcolor,UIColor *borderColor);


/**
 *  画圆角区域
 *
 *  @param context     上下文
 *  @param roundRect   区域
 *  @param corners     圆角位置
 *  @param cornerRadii 圆角尺寸
 *  @param bgcolor     颜色
 *  @param borderColor 边框颜色
 *  @param shadow      阴影颜色
 */
void CGDrawRoundRectWithParam(CGContextRef context,CGRect roundRect,UIRectCorner corners,CGSize cornerRadii,UIColor* bgcolor,UIColor *borderColor,UIColor *shadow);


/**
 *  点和点之间的距离
 *
 *  @param firstPoint  第一个点
 *  @param secondPoint 第二个点
 *
 *  @return 距离
 */
CGFloat distanceBetweenPoints(CGPoint firstPoint, CGPoint secondPoint);


/**
 *  计算文字中心点位置
 *
 *  @param str     字符串
 *  @param font    字体
 *  @param origin  起始点
 *  @param nAnchor 锚点
 *
 *  @return 中心点
 */
CGPoint getTextCenterPoint(NSString *str,UIFont *font,CGPoint origin,int nAnchor);


/**
 *  画group样式的cell
 *
 *  @param c           上下文
 *  @param roundRect   园角rect
 *  @param corners     圆角类型
 *  @param cornerRadii 圆角尺寸
 */
void CGDrawSampleGroupCell(CGContextRef c,CGRect roundRect,UIRectCorner corners,CGSize cornerRadii);


/**
 *  画有颜色的group样式的cell
 *
 *  @param c           上下文
 *  @param roundRect   圆角rect
 *  @param corners     圆角类型
 *  @param cornerRadii 圆角尺寸
 *  @param bgcolor     背景颜色
 *  @param withBorder  边缘尺寸
 */
void CGDrawSampleGroupCellWithColor(CGContextRef c,CGRect roundRect,UIRectCorner corners,CGSize cornerRadii,UIColor* bgcolor,BOOL withBorder);


/**
 *  画BS箭头, bBS=0画菱形, 否则画对应三角
 *
 *  @param context 上下文
 *  @param bBS     bs值
 *  @param nX      x坐标
 *  @param nY      y坐标
 *  @param color   颜色值
 */
void CGDrawTriBS(CGContextRef context, char bBS, int nX, int nY, UIColor *color);


/**
 *  画BS箭头, bBS=0画菱形, 否则画对应三角
 *
 *  @param context 上下文
 *  @param bBS     bs值
 *  @param nX      x坐标
 *  @param nY      y坐标
 *  @param color   颜色值
 */
void CGDrawFenbiTriBS(CGContextRef context, char bBS, int nX, int nY, UIColor *color);


/**
 *  画BS箭头
 *
 *  @param context 上下文
 *  @param cDirect 方向
 *  @param nX      x坐标
 *  @param nY      y坐标
 *  @param color   颜色值
 */
void CGDrawBSArrow(CGContextRef context, char cDirect, int nX, int nY, UIColor *color);


/**
 *  画BS点
 *
 *  @param context    上下文
 *  @param cDirect    方向
 *  @param nX         x坐标
 *  @param nY         y坐标
 *  @param bImageName b点图片名称
 *  @param sImageName s点图片名称
 */
void CGDrawBSPoint(CGContextRef context, char cDirect, int nX, int nY, NSString *bImageName, NSString *sImageName);



#ifdef __cplusplus
}
#endif

