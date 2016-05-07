//
//  RSA.m
//  test
//
//  Created by flora deng on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//参考地址:: http://blog.iamzsx.me/show.html?id=155002 


#import "RSA.h"

@interface RSA() {
    SecKeyRef publicKey;
    size_t maxPlainLen;
}

- (SecKeyRef)getSecKeyWithData:(NSData*)keyCotentData;

@end

@implementation RSA


- (instancetype)initWithPublicKey:(NSString *)publicKeyPath {
    if (publicKeyPath == nil) {
        NSLog(@"Can not find %@", publicKeyPath);
        return nil;
    }
    
    NSData *publicKeyFileContent = [NSData dataWithContentsOfFile:publicKeyPath];
    
    return [self initWithData:publicKeyFileContent];
}

- (instancetype)initWithData:(NSData *)KeyFileContent {
    if (self = [super init]) {
        if (KeyFileContent == nil) {
            NSLog(@"Can not read  %@",KeyFileContent);
            return NULL;
        }
        publicKey = [self getSecKeyWithData:KeyFileContent];
        maxPlainLen = SecKeyGetBlockSize(publicKey) - 12;
    }
    return self;
}


+ (NSString*)base64forData:(NSData*)theData {
	
	const uint8_t* input = (const uint8_t*)[theData bytes];
	NSInteger length = [theData length];
	
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
	
	NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
		NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
			
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
		
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
	
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}


- (SecKeyRef)getSecKeyWithData:(NSData *)KeyFileContent;
{
    
    if (KeyFileContent == nil) {
        NSLog(@"Can not read from %@",KeyFileContent);
        return NULL;    }

    SecCertificateRef certificate = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)KeyFileContent);
    if (certificate == nil) {
        NSLog(@"Can not read certificate from %@",KeyFileContent);
        return NULL;    }
    
    SecPolicyRef policy = SecPolicyCreateBasicX509();
    SecTrustRef trust;
    SecCertificateRef certs[1] = { certificate };
    CFArrayRef array = CFArrayCreate(NULL, (const void **) certs, 1, NULL);
    OSStatus returnCode = SecTrustCreateWithCertificates(array, policy, &trust);
    if (returnCode != 0) {
        CFRelease(array);
        CFRelease(policy);
        NSLog(@"%@ SecTrustCreateWithCertificates fail. Error Code: %d",KeyFileContent, (int)returnCode);
        return NULL;    }
    
    SecTrustResultType trustResultType;
    returnCode = SecTrustEvaluate(trust, &trustResultType);
    if (returnCode != 0) {
        CFRelease(array);
        CFRelease(policy);
        NSLog(@"%@ SecTrustEvaluate fail. Error Code: %d", KeyFileContent,(int)returnCode);
        return NULL;
    }
    
    SecKeyRef key = SecTrustCopyPublicKey(trust);
    if (key == nil) {
        CFRelease(array);
        CFRelease(policy);
        NSLog(@"SecTrustCopyPublicKey fail %@",KeyFileContent);
        return NULL;
    }
    
    CFRelease(certificate);
    CFRelease(trust);
    CFRelease(policy);
    CFRelease(array);
    
    return key;
}

- (NSData *)encryptWithData:(NSData *)content {

    size_t plainLen = [content length];
    if (plainLen > maxPlainLen) {
        NSLog(@"content(%ld) is too long, must < %ld", plainLen, maxPlainLen);
        return nil;
    }

    void *plain = malloc(plainLen);
    [content getBytes:plain
               length:plainLen];
    
    size_t cipherLen = 128; // 当前RSA的密钥长度是128字节
    void *cipher = malloc(cipherLen);

    OSStatus returnCode = SecKeyEncrypt(publicKey, kSecPaddingPKCS1, plain,
                                        plainLen, cipher, &cipherLen);

    NSData *result = nil;
    if (returnCode != 0) {
        NSLog(@"SecKeyEncrypt fail. Error Code: %d", (int)returnCode);
    }
    else {
        result = [NSData dataWithBytes:cipher
                                length:cipherLen];
    }

    free(plain);
    free(cipher);
    return result;
}

- (NSData *)encryptWithString:(NSString *)content {
    return [self encryptWithData:[content dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)base64encrytWithString:(NSString *)content
{
    return [[self class] base64forData:[self encryptWithString:content]];
}

- (void)dealloc{
    if (publicKey) {
        CFRelease(publicKey);        
    }
}

@end

