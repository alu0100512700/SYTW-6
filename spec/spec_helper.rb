$:.unshift File.expand_path(File.dirname(__FILE__)+'../lib')
$:.unshift File.dirname(__FILE__)

#puts $:.inspect

require 'rspec'
require 'rack'

require 'rsack'
require 'rps.rb'
