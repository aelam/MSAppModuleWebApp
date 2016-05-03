//
//  JSSourceCode.h
//  Pods
//
//  Created by ryan on 4/29/16.
//
//

#import <Foundation/Foundation.h>
#import "JSBridgeModule.h"

@interface JSSourceCode : NSObject <JSBridgeModule>

@property (nonatomic, copy) NSData *scriptData;
@property (nonatomic, copy) NSURL *scriptURL;

@end
