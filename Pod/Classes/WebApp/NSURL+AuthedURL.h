//
//  NSURL+AuthedURL.h
//  Pods
//
//  Created by ryan on 3/10/16.
//
//

#import <Foundation/Foundation.h>

@interface NSURL (AuthedURL)

+ (NSURL *)authedURLWithURL:(NSURL *)plainURL;

@end
