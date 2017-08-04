//
//  NSURL+RoutableURL.h
//  Pods
//
//  Created by ryan on 3/10/16.
//
//

#import <Foundation/Foundation.h>

@interface NSURL (RoutableURL)

/**
 * @param URL "http://www.baidu.com"
 * @return @"web?url=url_encoded(url)"
 */

+ (NSURL *)routableURLWithURL:(NSURL *)URL;

@end
