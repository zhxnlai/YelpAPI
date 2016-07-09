Pod::Spec.new do |s|
  s.name             = 'YelpAPI'
  s.version          = '0.1.0'
  s.summary          = 'Yelp API in Swift.'

  s.homepage         = 'https://github.com/zhxnlai/YelpAPI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Zhixuan Lai' => 'zhxnlai@gmail.com' }
  s.source           = { :git => 'https://github.com/zhxnlai/YelpAPI.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.0"
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Source/Base/*.swift'
  s.requires_arc = true
end
