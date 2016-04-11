Pod::Spec.new do |s|
  s.name = 'P2EPush'
  s.version = '1.0.0'
  s.summary = 'This SDK is used for Notification management via http://push2engage.com'
  s.license = 'Copyright (c) 2016 Push2Engage. All rights reserved'
  s.authors = {"Push2Engage"=>"support@push2engage.com"}
  s.homepage = 'https://push2engage.com'
  s.description = 'Push2Engage (http://push2engage.com) provides complete interface to send notification to various Mobile Platform. By using Push2Engage, businesses can uniquely target individual Mobile Device. Also businesses can target Mobile Device based on location.'
  s.frameworks = ["UIKit", "Foundation", "Security", "CoreLocation", "SystemConfiguration"]
  s.requires_arc = true
  s.source = { :git => "https://github.com/push2engage/p2e-ios-sdk.git", :tag => s.version.to_s }

  s.platform = :ios, '7.0'
  s.ios.platform             = :ios, '7.0'
  s.ios.preserve_paths       = 'P2EPush.framework'
  s.ios.public_header_files  = 'P2EPush.framework/Versions/A/Headers/*.h'
  s.ios.vendored_frameworks  = 'P2EPush.framework'
end
