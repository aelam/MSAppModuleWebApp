#
# Be sure to run `pod lib lint MSAppModuleWebApp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MSAppModuleWebApp"
  s.version          = "0.2.3"
  s.summary          = "MSAppModuleWebApp"

  s.description      = <<-DESC
    MSAppModuleWebApp
* [x]JS
* [x]MenuConfig
** [x]Share
** [x]Search
* [x]ZXG
* [x]Theme
* [x]Routes
                       DESC

  s.homepage         = "http://ph.benemind.com/diffusion/WEBAPP"
  s.license          = 'MIT'
  s.author           = { "Ryan Wang" => "wanglun02@gmail.com" }
  s.source           = { :git => "http://ph.benemind.com/diffusion/WEBAPP/msappmodulewebapp.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true


  s.subspec  'WebViewController' do |ss|
    ss.source_files = 'Pod/Classes/**/*'
    ss.resource     = 'Pod/Assets/**/*.js', 'Pod/Assets/**/*.png'

    ss.dependency 'UIColor-HexString', '~> 1.1.0'
    ss.dependency 'MSAppModuleShare'
    ss.dependency 'MSRoutes'
    ss.dependency 'MSThemeKit'
    ss.dependency 'MSAppModuleKit'
    ss.dependency 'EMSpeed/UIKit/Core'
    ss.dependency 'EMSpeed/UIKit/UIKitCollections'
    ss.dependency 'EMSpeed/UIKit/FontAwesome+iOS'
    ss.dependency 'RDVTabBarController'
    ss.dependency 'EMClick'
    ss.dependency 'SDWebImage'
    ss.dependency 'MSAppModuleWebApp/WebBridgeCore'
    ss.dependency 'UIImage+RTTint', '~> 1.0.0'
    ss.dependency 'Masonry'

  end


  s.subspec 'WebBridgeCore' do |ss|
    ss.source_files = 'Pod/Classes/WebBridgeCore/**/*'
    ss.frameworks = 'UIKit', 'Foundation', 'JavaScriptCore', 'WebKit'
    ss.dependency 'WebViewJavascriptBridge'

  end


end
