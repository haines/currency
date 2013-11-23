#!/usr/bin/env ruby
$: << File.expand_path("lib", __dir__)

require_relative "bundle/bundler/setup"

require "alfred"

require "environment/load"
require "converter"
require "formatter"

def feedback_for(alfred, input)
  alfred.ui.debug input.inspect
  Formatter.new(alfred.feedback).format(converter.convert(input))
end

def converter
  Converter.new
end

Alfred.with_friendly_error do |alfred|
  puts feedback_for(alfred, ARGV.first).to_xml
end
