//
//  EMCReportPolicy.h
//  EMClickDemo
//
//  Created by flora on 15/9/15.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#ifndef EMClickDemo_EMCReportPolicy_h
#define EMClickDemo_EMCReportPolicy_h

typedef NS_ENUM(NSUInteger, EMReportPolicy) {
    EMReportPolicyLaunch,
    EMReportPolicyInterval,
};

#define kEMClickReportUserURL  @"http://mlog.emoney.cn/ub2/Action/AddUserInfo"
#define kEMClickReportUserURL_DEBUG  @"http://192.168.19.72/UserAsy/action/AddUserInfo"

#define kEMClickReportPageURL  @"http://mlog.emoney.cn/ub2/Action/AddUserRecord"
#define kEMClickReportPageURL_DEBUG  @"http://192.168.19.72/UserAsy/action/AddUserRecord"

#endif
