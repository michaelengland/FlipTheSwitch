Pod::Spec.new do |s|
  s.name = 'FlipTheSwitch'
  s.version = '0.5.0'
  s.summary = 'A simple library to help enabling/disabling features on iOS/Mac applications.'
  s.authors = {
      'Michael England' => 'mg.england@gmail.com',
      'Rob Siwek' => 'rob@robsiwek.com'
  }
  s.homepage = 'https://github.com/michaelengland/FlipTheSwitch'

  s.license = {:type => 'MIT', :file => 'LICENSE'}
  s.source = {:git => 'git@github.com:michaelengland/FlipTheSwitch.git', :tag => s.version.to_s}
  s.ios.source_files = 'Classes/FlipTheSwitch/**/*.{h,m}'
  s.osx.source_files = 'Classes/FlipTheSwitch/Shared/*.{h,m}'
  s.ios.resource_bundles = { 'FlipTheSwitch' => 'Resources/FlipTheSwitch/*.storyboard' }
  s.public_header_files = 'Classes/FlipTheSwitch/*.h'
  s.requires_arc = true
end
