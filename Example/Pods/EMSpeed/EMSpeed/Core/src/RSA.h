//
//  RSA.h
//  test
//
//  Created by flora deng on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSA : NSObject

- (instancetype)initWithPublicKey:(NSString *)publicKeyPath;
- (instancetype)initWithData:(NSData *)keyData;

- (NSData *)encryptWithData:(NSData *)content;
- (NSData *)encryptWithString:(NSString *)content;
- (NSString *)base64encrytWithString:(NSString *)content;

@end

