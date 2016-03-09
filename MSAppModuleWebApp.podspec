#
# Be sure to run `pod lib lint MSAppModuleWebApp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MSAppModuleWebApp"
  s.version          = "0.1.0"
  s.summary          = "MSAppModuleWebApp"

  s.description      = <<-DESC
    MSAppModuleWebApp 
                       DESC

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/MSAppModuleWebApp"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Ryan Wang" => "wanglun02@gmail.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/MSAppModuleWebApp.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource     = 'Pod/Assets/**/*.js'

  s.frameworks = 'UIKit', 'Foundation', 'JavaScriptCore'
  s.dependency 'WebViewJavascriptBridge', '~> 4.1.4'
  s.dependency 'UIColor-HexString', '~> 1.1.0'
  s.dependency 'MSAppModuleShare'
  s.dependency 'MSRoutes'
  s.dependency 'MSThemeKit'
  s.dependency 'MSAppModuleKit'
  s.dependency 'EMSpeed/UIKit/Core'
  s.dependency 'EMSpeed/UIKit/UIKitCollections'
  s.dependency 'RDVTabBarController'
  s.dependency 'EMClick'


end
