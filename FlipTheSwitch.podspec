Pod::Spec.new do |s|
  s.name = 'FlipTheSwitch'
  s.version = '1.0.1'
  s.summary = 'A simple library to help enabling/disabling features on iOS/Mac applications.'
  s.authors = {
      'Michael England' => 'mg.england@gmail.com',
      'Rob Siwek' => 'rob@robsiwek.com'
  }
  s.homepage = 'https://github.com/michaelengland/FlipTheSwitch'

  s.license = {:type => 'MIT', :file => 'LICENSE'}
  s.source = {:git => 'https://github.com/michaelengland/FlipTheSwitch.git', :tag => s.version.to_s}
  s.osx.source_files = 'Classes/FlipTheSwitch/Shared/*.{h,m}'
  s.osx.public_header_files = 'Classes/FlipTheSwitch/Shared/*.h'
  s.osx.deployment_target = '10.8'
  s.ios.source_files = 'Classes/FlipTheSwitch/**/*.{h,m}'
  s.ios.public_header_files = 'Classes/FlipTheSwitch/**/*.h'
  s.ios.resource_bundles = { 'FlipTheSwitch' => 'Resources/FlipTheSwitch/*.storyboard' }
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
end
