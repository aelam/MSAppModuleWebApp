//
//  EMSettingsCondition.h
//  EMStock
//
//  Created by ryan on 3/9/16.
//  Copyright © 2016 flora. All rights reserved.
//

#ifndef __SETTINGS_CONDITION_H__
#define __SETTINGS_CONDITION_H__

#if __has_include(<EMWSPXModule/EMAppSettingsWSPX.h>)

#define __MODULE_WSPX_ENABLED__ 1

#endif /* __MODULE_WSPX_ENABLED__ */


#if __has_include(<MSMessage/MSMessageAppSettings.h>)

#define __MODULE_MESSAGE_ENABLED__ 1

#endif /* __MODULE_MESSAGE_ENABLED__ */


#if __has_include(<MSAppModuleShare/EMAppShareSettings.h>)

#define __MODULE_SHARE_ENABLED__ 1

#endif /* __MODULE_SHARE_ENABLED__ */


#if __has_include(<MSAppModuleWebApp/MSAppSettingsWebApp.h>)

#define __MODULE_WEB_APP_ENABLED__ 1

#endif /* __MODULE_WEB_APP_ENABLED__ */

#if __has_include(<MSAppModuleOnlineTrade/MSAppModuleOnlineTrade.h>)

#define __MODULE_ONLINE_TRADE_ENABLED__ 1

#endif /* __MODULE_ONLINE_TRADE_ENABLED__ */


#if __has_include(<EMInfoKit/EMInfoAppSetting.h>)

#define __MODULE_INFO_ENABLED__ 1

#endif

#endif /* __SETTINGS_CONDITION_H__ */
