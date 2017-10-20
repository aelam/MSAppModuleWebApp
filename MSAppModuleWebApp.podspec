Pod::Spec.new do |s|
  s.name             = "MSAppModuleWebApp"
  s.version          = "0.2.6"
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
    ss.dependency 'WebViewJavascriptBridge', '~> 6.0'
    ss.dependency 'MSAppModuleWebApp/WebView'
  end

  s.subspec  'WebControllerTheme' do |ss|
    ss.source_files = 'Pod/WebControllerTheme/**/*.{h,c,m,mm,swift}'
    ss.resource = 'Pod/WebControllerTheme/**/*.{plist}'
    ss.dependency 'MSThemeKit', "~> 1.0.0.beta.3"
  end

  s.subspec  'WebViewController' do |ss|
    ss.source_files = 'Pod/WebViewController/Class/**/*.{h,c,m,mm,swift}'
    ss.resource     = ['Pod/WebViewController/Assets/**/*.{xib}','Pod/WebViewController/Class/**/*.{xib}']
    ss.resource_bundles = {
      'WebAppImageResouceBundle' => ['Pod/WebViewController/Assets/**/*.png']
    }

    ss.dependency 'UIColor-HexString', '~> 1.1.0'
    ss.dependency 'MSAppModuleKit', '~> 1.0'
    ss.dependency 'EMSpeed/UIKit/Core'
    ss.dependency 'EMSpeed/UIKit/FontAwesome+iOS'
    ss.dependency 'EMSpeed/UIKit/UIKitCollections'
    ss.dependency 'SDWebImage'
    ss.dependency 'UIImage+RTTint', '~> 1.0.0'
    ss.dependency 'RDVTabBarController'
    ss.dependency 'Masonry'
    ss.dependency 'AFNetworking', '~> 3.1.0'

    ss.dependency 'MSAppModuleWebApp/WebBridgeCore'
    ss.dependency 'MSAppModuleWebApp/WebView'
    ss.dependency 'MSAppModuleWebApp/WebControllerTheme'
  end

  # 加载goods
  s.subspec 'WebAppBaseJSModule' do |ss|
    ss.source_files = 'Pod/WebAppBaseJSModule/**/*.{h,m}'
    ss.resource     = 'Pod/WebAppBaseJSModule/Assets/**/*.js'
    ss.dependency 'MSAppModuleWebApp/WebViewController'
  end

  # 加载加强版的goods方法
  s.subspec 'EMStockJSModules' do |ss|
    ss.source_files = 'Pod/EMStockJSModules/WebAppBridgeModules/**/*'
    ss.exclude_files = 'Pod/EMStockJSModules/WebAppBridgeModules/JSContextModule/**/*'
    ss.resource     = 'Pod/EMStockJSModules/Assets/**/*.js'
    ss.dependency   'MSAppModuleWebApp/WebAppBaseJSModule'
  end

  s.default_subspec = 'EMStockJSModules', 'WebViewController'



end
