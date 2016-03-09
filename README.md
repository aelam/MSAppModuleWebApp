# MSAppModuleWebApp

[![CI Status](http://img.shields.io/travis/Ryan Wang/MSAppModuleWebApp.svg?style=flat)](https://travis-ci.org/Ryan Wang/MSAppModuleWebApp)
[![Version](https://img.shields.io/cocoapods/v/MSAppModuleWebApp.svg?style=flat)](http://cocoapods.org/pods/MSAppModuleWebApp)
[![License](https://img.shields.io/cocoapods/l/MSAppModuleWebApp.svg?style=flat)](http://cocoapods.org/pods/MSAppModuleWebApp)
[![Platform](https://img.shields.io/cocoapods/p/MSAppModuleWebApp.svg?style=flat)](http://cocoapods.org/pods/MSAppModuleWebApp)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 
```lan=objc
EMAppSettings *appSettings = [EMAppSettings appSettings];

appSettings.webAppAuthInfo = ^NSDictionary *(void){
NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
parameters[@"loginType"] = @([EMAccount sharedAccount].loginType);
NSString *userId = [EMAccount sharedAccount].userID;
if (userId) {
parameters[@"userId"] = userId;
}
NSString *webAuthToken = [EMAccount sharedAccount].webAuthToken;
if (webAuthToken) {
parameters[@"webAuthToken"] = webAuthToken;
}

return parameters;
};

```



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

