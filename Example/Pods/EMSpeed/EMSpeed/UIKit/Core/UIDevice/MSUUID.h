//
//  EMUUID.h
//  ymStockHD
//
//  Created by flora on 13-10-18.
//
//

#import <Foundation/Foundation.h>

@interface MSUUID : NSObject

/**获取UUID
 *UUID是开发者+设备的唯一标识，但是由于在设备卸载开发者apps，并重新安装后，这个标示符会改变 （ios7+）
 *为了避免频繁的更新UUID对后台统一造成影响，将获取到的UUID存储在keychain中，以后直接从keychain中获取。
 *缺点：即使这样也不能完美的实现 APP 对于设备的唯一标识。在设备恢复出厂设置 或 升级大版本（有可能造成应用清空全部重新下载的情况），keychain会被清空，这个时候UUID依旧会变更。
 */
// Use [UIDevice currentDevice].uniqueGlobalDeviceIdentifier
+ (NSString *)getEMUUID;

@end


