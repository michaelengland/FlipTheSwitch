require 'rubygems'
require 'bundler/setup'
require 'spork'
require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start

Spork.prefork do
  require 'rspec'
end

Spork.each_run do
  require 'flip_the_switch'
  require 'flip_the_switch/cli'
end
