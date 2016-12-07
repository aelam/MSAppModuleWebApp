Pod::Spec.new do |s|
  s.name             = "MSAppModuleWebApp"
  s.version          = "1.0.0-beta.1"
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


  s.subspec 'WebView' do |ss|
    ss.source_files = 'Pod/WebView/**/*.{h,c,m,mm,swift}'
    ss.frameworks = 'UIKit', 'Foundation', 'JavaScriptCore', 'WebKit'
  end

  s.subspec 'WebBridgeCore' do |ss|
    ss.source_files = 'Pod/WebBridgeCore/**/*.{h,c,m,mm,swift}'
    ss.frameworks = 'UIKit', 'Foundation', 'JavaScriptCore', 'WebKit'
    ss.dependency 'WebViewJavascriptBridge'
    ss.dependency 'MSAppModuleWebApp/WebView'
  end

  s.subspec  'WebControllerTheme' do |ss|
    ss.source_files = 'Pod/WebControllerTheme/**/*.{h,c,m,mm,swift}'
    ss.resource = 'Pod/WebControllerTheme/**/*.{plist}'
    ss.dependency 'MSThemeKit', "~> 1.0.0.beta.3"
  end

  s.subspec  'WebViewController' do |ss|
    ss.source_files = 'Pod/WebApp/Class/**/*.{h,c,m,mm,swift}'
    ss.resource     = 'Pod/WebApp/Assets/**/*.png'

    ss.dependency 'UIColor-HexString', '~> 1.1.0'
    ss.dependency 'MSAppModuleShare', '~> 1.0-beta.1'
    ss.dependency 'MSAppModuleKit', '~> 1.0'
    ss.dependency 'EMSpeed/UIKit/Core'
    ss.dependency 'EMSpeed/UIKit/UIKitCollections'
    ss.dependency 'SDWebImage'
    ss.dependency 'UIImage+RTTint', '~> 1.0.0'
    ss.dependency 'RDVTabBarController'

    ss.dependency 'MSAppModuleWebApp/WebBridgeCore'
    ss.dependency 'MSAppModuleWebApp/WebView'

    ss.dependency 'EMSpeed/UIKit/FontAwesome+iOS'
    ss.dependency 'Masonry'
    ss.dependency 'EMSocialKit' , '~> 1.0-beta.2'

    ss.dependency 'MSAppModuleWebApp/WebControllerTheme'

  end

  s.subspec 'EMStock' do |ss|
    ss.source_files = 'Pod/EMStock/WebAppBridgeModules/**/*'
    ss.resource     = 'Pod/EMStock/Assets/**/*.js'
    ss.dependency   'MSAppModuleWebApp/WebBridgeCore'
    ss.dependency 'MSAppModuleWebApp/WebViewController'
  end

  s.default_subspec = 'EMStock', 'WebViewController'



end
