# MSAppModuleWebApp

[![CI Status](http://img.shields.io/travis/Ryan Wang/MSAppModuleWebApp.svg?style=flat)](https://travis-ci.org/Ryan Wang/MSAppModuleWebApp)
[![Version](https://img.shields.io/cocoapods/v/MSAppModuleWebApp.svg?style=flat)](http://cocoapods.org/pods/MSAppModuleWebApp)
[![License](https://img.shields.io/cocoapods/l/MSAppModuleWebApp.svg?style=flat)](http://cocoapods.org/pods/MSAppModuleWebApp)
[![Platform](https://img.shields.io/cocoapods/p/MSAppModuleWebApp.svg?style=flat)](http://cocoapods.org/pods/MSAppModuleWebApp)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## WebApp的配置

### 需要设置三个颜色, 见SettingsWebApp

### 关于webAppAuthInfo的配置 全部在主工程里面配置
```
    // 旧版代码
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    parameters[@"pd"] = @(appSettings.productID);
    parameters[@"ar"] = @(appSettings.platformID);
    parameters[@"mv"] = [UIApplication sharedApplication].versionDescription;
    parameters[@"vd"] = @(appSettings.vendorID);

    parameters[@"guid"] = [UIDevice currentDevice].uniqueGlobalDeviceIdentifier;
    parameters[@"systemVersion"] = [UIDevice currentDevice].systemVersion;

    if(appSettings.webAppAuthInfo) {
        NSDictionary *extraInfo = appSettings.webAppAuthInfo();
        [parameters addEntriesFromDictionary:extraInfo];
    }

``



## Requirements

## Installation

MSAppModuleWebApp is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MSAppModuleWebApp"
```

## Author

Ryan Wang, wanglun02@gmail.com

## License

MSAppModuleWebApp is available under the MIT license. See the LICENSE file for more info.

