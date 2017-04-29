#
# Be sure to run `pod lib lint SwiftySwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JLSwiftySwift'
  s.version          = '0.1.1'
  s.summary          = 'This is my description of this.'
  s.description      = "Test description"
  s.homepage         = 'https://github.com/hanjustin/'
  s.license          = "MIT"
  s.author           = { 'hanjustin' => 'jhankilee@gmail.com' }
  s.source           = { :git => 'https://github.com/hanjustin/SwiftySwift.git', :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SwiftySwift/**/*.{h,m,swift}'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }
  
  # s.resource_bundles = {
  #   'SwiftySwift' => ['SwiftySwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
