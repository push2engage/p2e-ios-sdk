#
# Be sure to run `pod lib lint P2EPush.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "P2EPush"
  s.version          = "1.0.0"
  s.summary          = "This SDK is used for Notification management via http://push2engage.com"
  s.description      = "Push2Engage (http://push2engage.com) provides complete interface to send notification to various Mobile Platform. By using Push2Engage, businesses can uniquely target individual Mobile Device. Also businesses can target Mobile Device based on location."

  s.homepage         = "http://push2engage.com"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'Copyright (c) 2016 Push2Engage. All rights reserved'
  s.author           = { "Push2Engage" => "support@push2engage.com" }
  s.source           = { :git => "https://emailatravi@bitbucket.org/emailatravi/p2e-ios-sdk.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  # s.resource_bundles = {
  #  'P2EPush' => ['Pod/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/**/Public/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'Security', 'CoreLocation', 'SystemConfiguration'
  s.dependency 'SSKeychain', '1.2.3'
  s.dependency 'Archiver', '1.0.4'
  s.dependency 'AutoEncodeDecode', '1.0.3'
  s.dependency 'INTULocationManager', '4.1.1'
  s.dependency 'Reachability', '3.2'
  s.dependency 'UIDevice-Hardware', '0.1.7'
end
