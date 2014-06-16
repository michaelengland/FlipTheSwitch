Gem::Specification.new do |s|
  s.name = 'flip_the_switch'
  s.authors = ['Michael England', 'Rob Siwek']
  s.email = %w(mg.england@gmail.com rob@robsiwek.com)
  s.summary = 'A simple library to help enabling/disabling features on iOS/Mac applications.'
  s.homepage = 'https://github.com/michaelengland/FlipTheSwitch'
  s.version = '0.3.0'

  s.files = `git ls-files`.split($\)
  s.executables = s.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})
end
