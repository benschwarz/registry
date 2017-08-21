# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'registry/version'

Gem::Specification.new do |spec|

  spec.name        = 'registry'
  spec.version     = Registry::VERSION
  spec.authors     = ['Ben Schwarz', 'Konstantin Gredeskoul']
  spec.date        = '2010-05-25'
  spec.description = 'A dirt cheap plugin registry system, as a factory pattern.'
  spec.summary     = 'A dirt cheap plugin registry system, as a factory pattern.'
  spec.email       = %w(ben.schwarz@gmail.com kigster@gmail.com)
  spec.homepage    = 'http://github.com/kigster/registry'
  spec.license     = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'colored2'
  spec.add_development_dependency 'irbtools'
  spec.add_development_dependency 'awesome_print'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'rspec-its'
end
