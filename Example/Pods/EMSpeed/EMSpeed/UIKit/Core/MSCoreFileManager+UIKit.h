//
//  MSCoreFileManager+UIKit.h
//  Pods
//
//  Created by ryan on 15/10/23.
//
//

#import <UIKit/UIKit.h>

/**
 *  保存图片到/caches/pic路径下
 *
 *  @param filename 文件名
 *  @param image 图片名
 *
 *  @return 是否成功
 */
BOOL MSFileManagerSaveImage(NSString *filename, UIImage *image);


/**
 *  读取图片
 *
 *  @param filePath 图片路径, 默认图片路径caches/pic/, 可以通过MSSetDefaultImageDirectory设置
 *
 *  @return 图片
 */
UIImage* MSFileManagerLoadImage(NSString *filename);
