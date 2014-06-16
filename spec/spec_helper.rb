require 'rubygems'
require 'bundler/setup'
require 'spork'

Spork.prefork do
  require 'rspec'
end

Spork.each_run do
  require 'flip_the_switch'
end
