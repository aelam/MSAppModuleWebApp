//
//  MSKeyChain.h
//  EMSpeed
//
//  Created by ryan on 15/12/16.
//
//

#import <Foundation/Foundation.h>

@interface MSKeychain : NSObject

+ (NSString *) getPasswordForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;
+ (BOOL) storeUsername: (NSString *) username andPassword: (NSString *) password forServiceName: (NSString *) serviceName updateExisting: (BOOL) updateExisting error: (NSError **) error;
+ (BOOL) deleteItemForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;

@end
