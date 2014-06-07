Pod::Spec.new do |s|
  s.name = 'FlipTheSwitch'
  s.version = '0.2.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'A simple library to help enabling/disabling features on iOS/Mac applications.'

  s.homepage = 'https://github.com/michaelengland/FlipTheSwitch'
  s.author = {
    'Michael England' => 'mg.england@gmail.com'
  }
  s.source = { :git => 'git@github.com:michaelengland/FlipTheSwitch.git', :tag => s.version.to_s }

  s.source_files = 'Pod/Classes/FlipTheSwitch/*.{h,m}'
  s.public_header_files = 'Pod/Classes/FlipTheSwitch/*.h'

  s.requires_arc = true
end
