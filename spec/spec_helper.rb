require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'registry'
require 'rspec'
require 'rspec/its'
require 'support/parser'

RSpec.configure do |config|
  
end
