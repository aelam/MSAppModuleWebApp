//
//  NSData+compress.h
//  ymStock
//
//  Created by flora on 13-10-23.
//
//

#import <Foundation/Foundation.h>

@interface NSData (Compress)

/**
 *  压缩算法
 *
 *  @return 压缩后的数据
 */
- (NSData *)compressData;

@end
